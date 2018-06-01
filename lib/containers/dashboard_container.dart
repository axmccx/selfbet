import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/dashboard_tab.dart';
import 'package:selfbet/presentation/transaction_screen.dart';

class DashboardContainer extends StatelessWidget {
  // set key

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DashboardTab(
          balance: vm.balance,
          atStake: vm.atStake,
          betTransacts: vm.betTransacts,
          uid: vm.uid,
          showBetTransact: vm.showBetTransact,
        );
      },
    );
  }
}

class _ViewModel {
  final bool loading;
  final int balance;
  final int atStake;
  final List<BetTransact> betTransacts;
  final String uid;
  final Function(BuildContext, BetTransact, String) showBetTransact;

  _ViewModel({
    @required this.loading,
    @required this.balance,
    @required this.atStake,
    @required this.betTransacts,
    @required this.uid,
    @required this.showBetTransact,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        loading: store.state.isLoading,
        balance: store.state.balance,
        atStake: store.state.atStake,
        betTransacts: store.state.betTransacts,
        uid: store.state.currentUser.uid,
        showBetTransact: (context, transaction, uid) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return TransactionScreen(transaction, uid);
            },
          ));
        }
    );
  }
}