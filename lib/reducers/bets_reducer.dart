import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

final betsReducer = combineReducers<List<Bet>>([
  TypedReducer<List<Bet>, LoadBetsAction>(_updateBets),
]);

List<Bet> _updateBets(List<Bet> betList, LoadBetsAction action) {
  return action.bets;
}