import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LogIn {
  final String username;
  final String password;

  LogIn(this.username, this.password);

  @override
  String toString() {
    return 'LogIn{Username: $username, Password: $password}';
  }
}

class LogInSuccessful {
  final FirebaseUser user;

  LogInSuccessful({ @required this.user});

  @override
  String toString() {
    return 'LogInSuccessful{user: $user}';
  }
}

class LogInFail {
  final dynamic error;
  LogInFail(this.error);
  @override
  String toString() {
    return 'LogInFail{There was an error loggin in: $error}';
  }
}

class CreateAccount {
  final String username;
  final String password;

  CreateAccount(this.username, this.password);

  @override
  String toString() {
    return 'CreateAccount{Username: $username, Password: $password}';
  }
}

class LogOut {
  @override
  String toString() {
    return 'LogOut{}';
  }
}

class LogOutSuccessful {
  LogOutSuccessful();
  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}

class MoveToRegister {
  @override
  String toString() {
    return 'MovetoRegister{}';
  }
}

class MoveToLogin {
  @override
  String toString() {
    return 'MoveToLogin{}';
  }
}