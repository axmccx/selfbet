import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LogInAction {
  final String username;
  final String password;

  LogInAction(this.username, this.password);

  @override
  String toString() {
    return 'LogIn{Username: $username, Password: $password}';
  }
}

class LogInSuccessfulAction {
  final FirebaseUser user;

  LogInSuccessfulAction({ @required this.user});

  @override
  String toString() {
    return 'LogInSuccessful{user: $user}';
  }
}

class LogInFailAction {
  final dynamic error;
  LogInFailAction(this.error);
  @override
  String toString() {
    return 'LogInFail{There was an error loggin in: $error}';
  }
}

class CreateAccountAction {
  final String username;
  final String password;
  final String name;

  CreateAccountAction(this.username, this.password, this.name);

  @override
  String toString() {
    return 'CreateAccount{Username: $username, Password: $password, Name: $name}';
  }
}

class LogOutAction {
  @override
  String toString() {
    return 'LogOut{}';
  }
}

class LogOutSuccessfulAction {
  LogOutSuccessfulAction();
  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}

class MoveToRegisterAction {
  @override
  String toString() {
    return 'MovetoRegister{}';
  }
}

class MoveToLoginAction {
  @override
  String toString() {
    return 'MoveToLogin{}';
  }
}