import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'dart:async';

final groupStreamReducer = combineReducers<StreamSubscription>([
  TypedReducer<StreamSubscription, SetGroupStreamAction>(_updateGroupSteam),
  TypedReducer<StreamSubscription, LogOutSuccessfulAction>(_clearGroupStream),
]);

StreamSubscription _updateGroupSteam(StreamSubscription name, SetGroupStreamAction action) {
  return action.groupSteam;
}

Null _clearGroupStream(StreamSubscription name, LogOutSuccessfulAction action) {
  return null;
}