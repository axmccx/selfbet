import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<FirebaseUser>([
  new TypedReducer<FirebaseUser, LogInSuccessfulAction>(_logIn),
  new TypedReducer<FirebaseUser, LogOutAction>(_logOut),
]);

FirebaseUser _logIn(FirebaseUser user, action) {
  return action.user;
}

Null _logOut(FirebaseUser user, action) {
  return null;
}