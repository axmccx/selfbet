import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseUserRepo {
  final FirebaseAuth auth;
  final Firestore firestore;
  static const String userPath = 'users';
  static const String betTransactPath = 'transactions';

  const FirebaseUserRepo(this.auth, this.firestore);

  Future<FirebaseUser> login(String username, String password) async {
    return await auth.signInWithEmailAndPassword(
      email: username,
      password: password,
    );
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await auth.currentUser();
  }

  Future<void> createUserEmailPass(
      String username,
      String password,
      String name,
      ) async {
    FirebaseUser user = await auth.createUserWithEmailAndPassword(
      email: username,
      password: password,
    );
    await firestore.collection(userPath).document(user.uid).setData(
      {
        "name": name,
        "balance": 0,
        "atStake": 0,
        "email": user.email,
      }
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Stream<UserEntity> userStream(String uid) {
     return firestore.collection(userPath).document(uid).snapshots.map((doc) {
       return UserEntity (
         uid: uid,
         name: doc["name"],
         balance: doc["balance"],
         atStake: doc["atStake"],
       );
     });
  }

  Stream<List<BetTransact>> betTransactStream(String uid) {
    return firestore.collection(betTransactPath)
        .where('members.' + uid, isGreaterThan: 0)
        .orderBy('members.' + uid, descending: true)
        .snapshots
        .map((snapshot) {
          return snapshot.documents.map((doc) {
            BetType type = stringToBetType(doc['betType']);
            return BetTransact(
              uid: doc['uid'],
              amount: doc['amount'] as int,
              groupName: doc['group'],
              betType: type,
              date: DateTime.fromMillisecondsSinceEpoch(doc['date'] as int),
              isWon: doc['isWon'] as bool,
              calcedAtStake: doc['calcedAtStake'],
              recipients: doc['recipients'],
            );
          }).toList();
    });
  }

  Future<void> addCredits(String uid) async {
    await firestore.collection(userPath).document(uid).get().then((doc) {
     int newBalance = doc["balance"] + 2000;
     firestore.collection(userPath).document(uid).updateData({
       "balance": newBalance,
     });
    });
  }

  Future<List<UserEntity>> getGroupMembers(Map groupMemberUids) async {
    List<UserEntity> out = [];
    for (String uid in groupMemberUids.keys) {
      await firestore.collection(userPath).document(uid).get().then((doc) {
        out.add(UserEntity (
          uid: uid,
          name: doc["name"],
          balance: doc["balance"],
          atStake:  doc["atStake"],
        ));
      });
    }
    return out;
  }

  Future<void> updateBalanceAtStake(String uid, int amount) {
    return firestore.collection(userPath)
        .document(uid).get().then((doc) {
      int newBalance = doc["balance"] - amount;
      int newAtStake = doc["atStake"] + amount;
      firestore.collection(userPath)
          .document(uid).updateData(
          {
            "balance": newBalance,
            "atStake": newAtStake,
          }
      );
    });
  }

  Future<List<UserEntity>> getTransactionMembers(BetTransact transaction) async {
    List<UserEntity> out = [];
    await firestore.collection(userPath).document(transaction.uid).get().then((doc) {
      out.add(UserEntity (
        uid: transaction.uid,
        name: doc["name"],
        balance: doc["balance"],
        atStake:  doc["atStake"],
        amountTrans: transaction.amount,
      ));
    });
    for (String uid in transaction.recipients.keys) {
      await firestore.collection(userPath).document(uid).get().then((doc) {
        out.add(UserEntity (
          uid: uid,
          name: doc["name"],
          balance: doc["balance"],
          atStake:  doc["atStake"],
          amountTrans: transaction.recipients[uid],
        ));
      });
    }
    return out;
  }

}