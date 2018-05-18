import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';

class FirebaseGroupsRepo {
  static const String groupPath = 'groups';
  static const String userPath = 'users';

  final Firestore firestore;
  const FirebaseGroupsRepo(this.firestore);
  // needs the firestore instance

  Future<void> createGroup(Group group) {
    return firestore.collection(groupPath)
        .document(group.name)
        .setData(group.toJson());
  }

//  Stream<List<Group>> groups() {
//
//  }
}