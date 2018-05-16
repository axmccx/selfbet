import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/dashboard_tab.dart';

class DashboardContainer extends StatelessWidget {
  // set key

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DashboardTab(
          balance: vm.balance,
          atStake: vm.atStake,
        );
      },
    );
  }
}

class _ViewModel {
  final bool loading;
  final int balance;
  final int atStake;

  _ViewModel({
    @required this.loading,
    @required this.balance,
    @required this.atStake
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        loading: store.state.isLoading,
        balance: store.state.balance,
        atStake: store.state.atStake
    );
  }
}