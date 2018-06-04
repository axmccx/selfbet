import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LogInAction {
  final String username;
  final String password;
  final Function onFail;

  LogInAction(this.username, this.password, this.onFail);

  @override
  String toString() {
    return 'LogInAction{Username: $username, Password: $password}';
  }
}

class LogInSuccessfulAction {
  final FirebaseUser user;

  LogInSuccessfulAction({ @required this.user});

  @override
  String toString() {
    return 'LogInSuccessfulAction{user: $user}';
  }
}

class LogInFailAction {
  final dynamic error;

  LogInFailAction(this.error);

  @override
  String toString() {
    return 'LogInFailAction{error: $error}';
  }
}

class CreateAccountAction {
  final String username;
  final String password;
  final String name;
  final Function onFail;

  CreateAccountAction(this.username, this.password, this.name, this.onFail);

  @override
  String toString() {
    return 'CreateAccountAction{Username: $username, Password: $password, Name: $name}';
  }
}

class LogOutAction {
  @override
  String toString() {
    return 'LogOutAction{}';
  }
}

class LogOutSuccessfulAction {
  @override
  String toString() {
    return 'LogOutSuccessfulAction{}';
  }
}

class MoveToRegisterAction {
  @override
  String toString() {
    return 'MoveToRegisterAction{}';
  }
}

class MoveToLoginAction {
  @override
  String toString() {
    return 'MoveToLoginAction{}';
  }
}