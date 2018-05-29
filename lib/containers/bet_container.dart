import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/presentation/bet_list.dart';

class BetsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BetList(
          bets: vm.bets,
          onExpireBet: vm.onExpireBet,
          onDeleteBet: vm.onDeleteBet,
          onRenewBet: vm.onRenewBet,
          onSnoozeAlarmBet: vm.onSnoozeAlarmBet,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Bet> bets;
  final Function(Bet) onExpireBet;  // temp function for testing
  final Function(Bet) onDeleteBet;
  final Function(Bet) onRenewBet;
  final Function(Bet) onSnoozeAlarmBet;

  _ViewModel({
    @required this.bets,
    @required this.onExpireBet,
    @required this.onDeleteBet,
    @required this.onRenewBet,
    @required this.onSnoozeAlarmBet,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      bets: store.state.bets,
      onExpireBet: (bet) {
        store.dispatch(ExpireBetAction(bet));
      },
      onDeleteBet: (bet) {
        store.dispatch(DeleteBetAction(bet));
      },
      onRenewBet: (bet) {
        store.dispatch(RenewBetAction(bet));
      },
      onSnoozeAlarmBet: (bet) {
        store.dispatch(SnoozeAlarmBetAction(bet));
      },
    );
  }
}