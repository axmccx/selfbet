import 'package:selfbet/actions/auth_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LogInAction>(_setLoading),
  TypedReducer<bool, LogInSuccessfulAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setLoading(bool state, action) {
  return true;
}