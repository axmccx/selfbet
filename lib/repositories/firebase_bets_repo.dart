import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseBetsRepo {
  static const String betPath = 'bets';
  
  final Firestore firestore;
  const FirebaseBetsRepo(this.firestore);

  Stream<List<Bet>> betStream(String uid) {
    return firestore.collection(betPath)
        .where('uid', isEqualTo: uid)
        .snapshots
        .map((snapshot) {
          return snapshot.documents.map((doc) {
            BetType type = stringToBetType(doc['type']);
            DateTime expiryDate = DateTime.parse(doc['expiryDate']);
            return Bet(
              uid: doc['uid'],
              betId: doc.documentID,
              amount: doc['amount'] as int,
              groupName: doc['group'],
              type: type,
              isExpired: doc['isExpired'] as bool,
              expiryDate: expiryDate,
              winCond: doc['winCond'] as bool,
              options: doc['options'],
            );
          }).toList();
    });
  }

  Future<void> placeBet(Bet bet) {
    return firestore.collection(betPath).add(bet.toJson());
  }

  Future<void> expireBet(Bet bet) {   //Temp function for testing!
    return firestore.collection(betPath).document(bet.betId).updateData({
      "isExpired": true,
    });
  }

  Future<void> deleteBet(Bet bet) {
    return firestore.collection(betPath).document(bet.betId).delete();
  }

  Future<void> renewBet(Bet bet) {
    return firestore.collection(betPath).document(bet.betId).updateData({
      "isExpired": false,
      "expiryDate": DateTime.now().add(Duration(days: 7)).toIso8601String(),
      // TODO deal with resetting bet options
    });
  }
}