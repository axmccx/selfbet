import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';

final atStakeReducer = combineReducers<int>([
  TypedReducer<int, LoadDashboard>(_updateAtStake),
]);

int _updateAtStake(int currentStake, LoadDashboard action) {
  return action.userEntity.atStake;
}