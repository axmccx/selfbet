import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/presentation/place_bet_screen.dart';

class PlaceBetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return PlaceBetScreen(
          balance: vm.balance,
          groups: vm.groups,
          onSubmit: vm.onSubmit,
        );
      },
    );
  }
}

class _ViewModel {
  final int balance;
  final List<Group> groups;
  final OnBetSubmit onSubmit;

  _ViewModel({
    @required this.balance,
    @required this.groups,
    @required this.onSubmit,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      balance: store.state.balance,
      groups: store.state.groups,
      onSubmit: (amount, type, groupName, options) {
        bool winCond;
        if (type == BetType.alarmClock) { winCond = true; }
        else { winCond = false; }
        store.dispatch(PlaceBetAction(Bet(
          uid: store.state.currentUser.uid,
          amount: amount,
          type: type,
          groupName: groupName,
          isExpired: false,
          expiryDate: DateTime.now().add(Duration(days: 7)),
          winCond: winCond,
          options: options,
        )));
      }
    );
  }
}
