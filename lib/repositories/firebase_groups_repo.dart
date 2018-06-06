import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseGroupsRepo {
  static const String groupPath = 'groups';

  final Firestore firestore;
  const FirebaseGroupsRepo(this.firestore);

  Stream<List<Group>> groupStream(String uid) {
    return firestore.collection(groupPath)
        .where('members.' + uid, isGreaterThan: 0)
        .orderBy('members.' + uid)
        .snapshots
        .map((snapshot) {
          return snapshot.documents.map((doc) {
            int groupAtStake = doc['membersAtStake'].values
                .reduce((prev, atStake) => prev + atStake);
            return Group(
              name: doc['name'],
              members: doc['members'],
              membersAtStake: doc['membersAtStake'],
              groupAtStake: groupAtStake,
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
      if (doc.exists && doc.data['members'].containsKey(uid)) {
        return 'Already member of group $groupName';
      } else if (doc.exists) {
        firestore.collection(groupPath).document(groupName).updateData(
            {
              "members.$uid": DateTime.now().millisecondsSinceEpoch,
              "membersAtStake.$uid": 0,
            }
        );
        return null;
      }
      else {
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

  Future<void> updateGroupAtStake(String groupName, String uid, int amount) {
    return firestore.collection(groupPath)
        .document(groupName).get().then((doc) {
      int newAtStake = doc['membersAtStake'][uid] + amount;
      firestore.collection(groupPath)
          .document(groupName).updateData(
          {
            "membersAtStake.$uid": newAtStake,
          }
      );
    });
  }

  Future<void> leaveGroup(String groupName, String uid) {
    return firestore.collection(groupPath)
        .document(groupName).get().then((doc) {
          Map members = doc["members"];
          Map membersAtStake = doc['membersAtStake'];
          members.remove(uid);
          membersAtStake.remove(uid);
          firestore.collection(groupPath)
              .document(groupName).updateData(
            {
              "members": members,
              "membersAtStake": membersAtStake,
            }
          );
    });
  }

  Future<void> deleteGroup(String groupName) {
    return firestore.collection(groupPath)
        .document(groupName).delete();
  }
}