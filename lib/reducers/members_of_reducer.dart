import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

final membersOfReducer = combineReducers<List<UserEntity>>([
  TypedReducer<List<UserEntity>, LoadGroupMembersAction>(_updateGroupMembers),
  TypedReducer<List<UserEntity>, LoadTransactionMembersAction>(_updateTransMembers),
]);

List<UserEntity> _updateGroupMembers(
    List<UserEntity> groupList,
    LoadGroupMembersAction action) {
  return action.groupMembers;
}

List<UserEntity> _updateTransMembers(
    List<UserEntity> groupList,
    LoadTransactionMembersAction action) {
  return action.transactMembers;
}