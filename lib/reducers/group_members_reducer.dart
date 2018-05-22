import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

final groupMembersReducer = combineReducers<List<UserEntity>>([
  TypedReducer<List<UserEntity>, LoadGroupMembersAction>(_updateGroupMembers),
]);

List<UserEntity> _updateGroupMembers(List<UserEntity> groupList, LoadGroupMembersAction action) {
  return action.groupMembers;
}

