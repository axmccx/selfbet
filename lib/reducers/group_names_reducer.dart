import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';

final groupNamesReducer = combineReducers<List<dynamic>>([
  TypedReducer<List<dynamic>, LoadDashboard>(_updateGroupNames),
]);

List<dynamic> _updateGroupNames(List<dynamic> groupList, LoadDashboard action) {
  return action.userEntity.groupNames;
}