import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

final betsReducer = combineReducers<List<Bet>>([
  TypedReducer<List<Bet>, PlaceHolderAction>(_updateBets),
]);

List<Bet> _updateBets(List<Bet> betList, PlaceHolderAction action) {
  return null;
}