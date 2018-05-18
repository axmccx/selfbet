import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';


class FirebaseBetsRepo {

  final Firestore firestore;

  const FirebaseBetsRepo(this.firestore);

}