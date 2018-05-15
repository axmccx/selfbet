import 'package:selfbet/actions/actions.dart';
import 'package:redux/redux.dart';

final balanceReducer = combineReducers<int>([
  TypedReducer<int, CreditFaucet>(creditFaucet),
]);

int creditFaucet(int currentBalance, CreditFaucet action) {
  return currentBalance + 2000;
}