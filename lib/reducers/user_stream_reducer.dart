import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'dart:async';

final userStreamReducer = combineReducers<StreamSubscription>([
  TypedReducer<StreamSubscription, SetUserStream>(_updateUserSteam),
  TypedReducer<StreamSubscription, LogOutSuccessfulAction>(_clearUserStream),
]);

StreamSubscription _updateUserSteam(StreamSubscription name, SetUserStream action) {
  return action.userStream;
}

Null _clearUserStream(StreamSubscription name, LogOutSuccessfulAction action) {
  return null;
}