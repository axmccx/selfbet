import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';

final atStakeReducer = combineReducers<int>([
  TypedReducer<int, LoadDashboardAction>(_updateAtStake),
]);

int _updateAtStake(int currentStake, LoadDashboardAction action) {
  return action.userEntity.atStake;
}