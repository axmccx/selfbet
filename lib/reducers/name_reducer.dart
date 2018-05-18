import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';

final nameReducer = combineReducers<String>([
  TypedReducer<String, LoadDashboard>(_updateName),
]);

String _updateName(String name, LoadDashboard action) {
  return action.userEntity.name;
}