import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/money_tab.dart';

class MoneyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return MoneyTab(
            callback: () {
              if (vm.balance == 0) {
                vm.addCredits();
                final snackBar = SnackBar(
                  content: Text("Added \$20 to your account"),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                final snackBar = SnackBar(
                  content: Text("Balance must be zero!"),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
          );
        }
    );
  }
}

class _ViewModel {
  final int balance;
  final Function addCredits;

  _ViewModel({
    @required this.balance,
    @required this.addCredits,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        balance: store.state.balance,
        addCredits: () => store.dispatch(CreditFaucet()),
    );
  }
}