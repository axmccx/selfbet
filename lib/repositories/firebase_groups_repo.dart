import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseGroupsRepo {
  static const String groupPath = 'groups';

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

  Future<String> createGroup(Group group) {
    return firestore.collection(groupPath).document(group.name).get()
        .then((doc) {
          if (doc.exists) {
            return 'Group already exists';
          } else {
            firestore.collection(groupPath)
                .document(group.name)
                .setData(group.toJson());
            return null;
          }
    });
  }

  Future<String> joinGroup(String groupName, String uid) {
    return firestore.collection(groupPath)
        .document(groupName).get().then((doc) {
      if (doc.exists) {
        firestore.collection(groupPath).document(groupName).updateData(
          {
            "members.$uid": true,
          }
        );
        return null;
      } else {
        return 'Group doesn\'t exists';
      }
    });
  }

  Future<void> updateGroupOwner(String groupName, String newOwnerName) {
    return firestore.collection(groupPath)
        .document(groupName).updateData(
      {
        "owner": newOwnerName,
      }
    );
  }

  Future<void> leaveGroup(String groupName, String uid) {
    return firestore.collection(groupPath)
        .document(groupName).get().then((doc) {
          Map members = doc["members"];
          members.remove(uid);
          firestore.collection(groupPath)
              .document(groupName).updateData(
            {
              "members": members,
            }
          );
    });
  }

  Future<void> deleteGroup(String groupName) {
    return firestore.collection(groupPath)
        .document(groupName).delete();
  }
}