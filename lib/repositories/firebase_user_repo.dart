import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseUserRepo {
  final FirebaseAuth auth;
  final Firestore firestore;
  static const String userPath = 'users';

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
        "groupNames": [],
      }
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Stream<UserEntity> userStream(String uid) {
     return firestore.collection(userPath).document(uid).snapshots.map((doc) {
       return UserEntity (
         doc["name"],
         doc["balance"],
         doc["atStake"],
         doc["groupNames"],
       );
     });
  }
}