import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';

final atStakeReducer = combineReducers<int>([
  TypedReducer<int, PlaceHolderAction>(_updateAtStake),
]);

int _updateAtStake(int currentStake, PlaceHolderAction action) {
  return 0;
}