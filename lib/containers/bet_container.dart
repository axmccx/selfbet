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
          onWinBet: vm.onWinBet,
          onDeleteBet: vm.onDeleteBet,
          onRenewBet: (bet) {
            Group selectedGroup = vm.groups.where((group) {
              return group.name == bet.groupName;
            }).toList().first;
            if (selectedGroup.members.length < 2) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      content: Text(
                        "You are the only member in the group ${selectedGroup.name}. "
                            "Who will receive your money if you lose? :)\n\n"
                            "Ask a friend to join the group so you can renew the bet.",
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                        ),
                      ],
                    ),
              );
            }
            else if (vm.balance < bet.amount) {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      content: Text(
                        "That balance is looking too short man",
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('Yes, I am poor'),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                        ),
                      ],
                    ),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                  AlertDialog(
                    content: Text(
                      "Renewing bet of "
                          "\$${(bet.amount/100).toStringAsFixed(2)} "
                          "Are you sure?",
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          child: const Text('Do it!'),
                          onPressed: () {
                            Navigator.pop(context);
                            vm.onRenewBet(bet);
                          }
                      ),
                      new FlatButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ],
                  ),
              );
            }
          },
          onSnoozeAlarmBet: vm.onSnoozeAlarmBet,
        );
      },
    );
  }
}

class _ViewModel {
  final int balance;
  final List<Bet> bets;
  final List<Group> groups;
  final Function(Bet) onExpireBet;  // temp function for testing
  final Function(Bet) onWinBet;     // temp function for testing
  final Function(Bet) onDeleteBet;
  final Function(Bet) onRenewBet;
  final Function(Bet) onSnoozeAlarmBet;

  _ViewModel({
    @required this.balance,
    @required this.bets,
    @required this.groups,
    @required this.onExpireBet,
    @required this.onWinBet,
    @required this.onDeleteBet,
    @required this.onRenewBet,
    @required this.onSnoozeAlarmBet,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      balance: store.state.balance,
      bets: store.state.bets,
      groups: store.state.groups,
      onExpireBet: (bet) {
        store.dispatch(ExpireBetAction(bet));
      },
      onWinBet: (bet) {
        store.dispatch(SetWinBetAction(bet));
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