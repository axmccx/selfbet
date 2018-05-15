import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

final groupsReducer = combineReducers<List<Group>>([
  TypedReducer<List<Group>, PlaceHolderAction>(_updateGroups),
]);

List<Group> _updateGroups(List<Group> groupList, PlaceHolderAction action) {
  return null;
}