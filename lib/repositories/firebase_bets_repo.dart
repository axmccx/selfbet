import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseBetsRepo {
  static const String betPath = 'bets';
  
  final Firestore firestore;
  const FirebaseBetsRepo(this.firestore);

  Stream<List<Bet>> betStream(String uid) {
    return firestore.collection(betPath)
        .where('user', isEqualTo: uid)
        .snapshots
        .map((snapshot) {
          return snapshot.documents.map((doc) {
            BetType type = stringToBetType(doc['type']);
            DateTime expiryDate = DateTime.parse(doc['expiryDate']);
            return Bet(
              amount: doc['amount'] as int,
              groupName: doc['group'],
              type: type,
              isExpired: doc['isExpired'] as bool,
              expiryDate: expiryDate,
              options: doc['options'],
            );
          }).toList();
    });
  }

  Future<void> placeBet(Bet bet, String uid) {
    return firestore.collection(betPath).add(bet.toJson()).then(
        (doc) {
          doc.updateData({
            "user": uid,
          });
        });
  }
}