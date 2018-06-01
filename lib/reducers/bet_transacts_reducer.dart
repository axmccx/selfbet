import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

final betTransactsReducer = combineReducers<List<BetTransact>>([
  TypedReducer<List<BetTransact>, LoadBetTransactAction>(_updateBetTransact),
]);

List<BetTransact> _updateBetTransact(
    List<BetTransact> betTransactList,
    LoadBetTransactAction action
    ) {
  return action.betTransacts;
}