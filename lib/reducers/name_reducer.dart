import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';

final nameReducer = combineReducers<String>([
  TypedReducer<String, LoadDashboardAction>(_updateName),
]);

String _updateName(String name, LoadDashboardAction action) {
  return action.userEntity.name;
}