import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'dart:async';

final betStreamReducer = combineReducers<StreamSubscription>([
  TypedReducer<StreamSubscription, SetBetStreamAction>(_updateBetStream),
  TypedReducer<StreamSubscription, LogOutSuccessfulAction>(_clearBetStream),
]);

StreamSubscription _updateBetStream(StreamSubscription name, SetBetStreamAction action) {
  return action.betStream;
}

Null _clearBetStream(StreamSubscription name, LogOutSuccessfulAction action) {
  return null;
}