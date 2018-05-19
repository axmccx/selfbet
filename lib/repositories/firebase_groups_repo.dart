import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseGroupsRepo {
  static const String groupPath = 'groups';
  //static const String userPath = 'users';

  final Firestore firestore;
  const FirebaseGroupsRepo(this.firestore);

  Stream<List<Group>> groupStream(String uid) {
    return firestore.collection(groupPath)
        .where('members.' + uid, isEqualTo: true)
        .snapshots
        .map((snapshot) {
          return snapshot.documents.map((doc) {
            return Group(
              name: doc['name'],
              members: doc['members'],
              groupAtStake: doc['groupAtStake'],
              owner: doc['owner'],
            );
          }).toList();
    });
  }

  Future<void> createGroup(Group group) {
    return firestore.collection(groupPath).document(group.name).get()
        .then((doc) {
          if (doc.exists) {
            // deal with error
          } else {
            firestore.collection(groupPath)
                .document(group.name)
                .setData(group.toJson());
          }
    });
  }
}