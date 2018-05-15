import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';

class Dashboard extends StatelessWidget {
  // set key

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return new Column(
          children: <Widget>[
            new Text("Balance: ${vm.balance}"),
            new Text("At Stake: ${vm.atStake}"),
          ],
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