import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LogInAction>(_setLoading),
  TypedReducer<bool, LogInSuccessfulAction>(_setLoaded),
  TypedReducer<bool, CreateAccountAction>(_setLoading),
  TypedReducer<bool, GetGroupMembersAction>(_setLoading),
  TypedReducer<bool, LoadGroupMembersAction>(_setLoaded),
  TypedReducer<bool, GetTransactionMembersAction>(_setLoading),
  TypedReducer<bool, LoadTransactionMembersAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setLoading(bool state, action) {
  return true;
}