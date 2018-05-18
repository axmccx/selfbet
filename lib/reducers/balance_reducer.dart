import 'package:selfbet/actions/actions.dart';
import 'package:redux/redux.dart';

final balanceReducer = combineReducers<int>([
  TypedReducer<int, LoadDashboard>(loadBalance),
]);

int loadBalance(int currentBalance, LoadDashboard action) {
  return action.userEntity.balance;
}