import 'package:selfbet/actions/actions.dart';
import 'package:redux/redux.dart';

final balanceReducer = combineReducers<int>([
  TypedReducer<int, CreditFaucet>(creditFaucet),
  TypedReducer<int, LoadDashboard>(loadBalance),
]);

int creditFaucet(int currentBalance, CreditFaucet action) {
  return currentBalance + 2000;
}

int loadBalance(int currentBalance, LoadDashboard action) {
  return action.userEntity.balance;
}