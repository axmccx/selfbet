import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'dart:async';

final betTransactStreamReducer = combineReducers<StreamSubscription>([
  TypedReducer<StreamSubscription, SetBetTransactStreamAction>(
      _updateBetTransactStream
  ),
  TypedReducer<StreamSubscription, LogOutSuccessfulAction>(
      _clearBetTransactStream
  ),
]);

StreamSubscription _updateBetTransactStream(
    StreamSubscription name,
    SetBetTransactStreamAction action
    ) {
  return action.betTransactStream;
}

Null _clearBetTransactStream(
    StreamSubscription name, 
    LogOutSuccessfulAction action) {
  return null;
}