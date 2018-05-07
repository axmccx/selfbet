import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInEmailAndPass(String email, String password);
  Future<String> createUserEmailandPass(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInEmailAndPass(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.uid;
  }

  Future<String> createUserEmailandPass(String email, String password) async {
    FirebaseUser user = await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}