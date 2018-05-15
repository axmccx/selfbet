import 'package:selfbet/actions/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadDashboard>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}