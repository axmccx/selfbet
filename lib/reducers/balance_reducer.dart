import 'package:selfbet/actions/actions.dart';
import 'package:redux/redux.dart';

final balanceReducer = combineReducers<int>([
  TypedReducer<int, LoadDashboardAction>(loadBalance),
]);

int loadBalance(int currentBalance, LoadDashboardAction action) {
  return action.userEntity.balance;
}