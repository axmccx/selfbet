import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/bet_tile.dart';


class BetList extends StatelessWidget {
  final List<Bet> bets;
  final Function onExpireBet;
  final Function onDeleteBet;
  final Function onRenewBet;
  final Function onSnoozeAlarmBet;

  BetList({
    @required this.bets,
    @required this.onExpireBet,
    @required this.onDeleteBet,
    @required this.onRenewBet,
    @required this.onSnoozeAlarmBet,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bets.length,
      itemBuilder: (BuildContext context, int index) {
        final bet = bets[index];
        return BetTile(
          bet: bet,
          onExpireBet: onExpireBet,
          onDeleteBet: onDeleteBet,
          onRenewBet: onRenewBet,
          onSnoozeAlarmBet: onSnoozeAlarmBet,
        );
      },
    );
  }
}
