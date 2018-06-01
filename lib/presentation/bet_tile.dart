import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/bet_tile_builder.dart';

class BetTile extends StatelessWidget {
  final Bet bet;
  final Function onExpireBet;   //temp function for testing
  final Function onWinBet;      // temp function for testing
  final Function onDeleteBet;
  final Function onRenewBet;
  final Function onSnoozeAlarmBet;

  BetTile({
    @required this.bet,
    @required this.onExpireBet,
    @required this.onWinBet,
    @required this.onDeleteBet,
    @required this.onRenewBet,
    @required this.onSnoozeAlarmBet,
  });

  @override
  Widget build(BuildContext context) {
    BetTileBuilder builtTile = BetTileBuilder(
        bet: bet,
        onExpireBet: onExpireBet,
        onWinBet: onWinBet,
        onDeleteBet: onDeleteBet,
        onRenewBet: onRenewBet,
        onSnoozeAlarmBet: onSnoozeAlarmBet,
    );
    return new Column(
      children: <Widget>[
        ExpansionTile(
          leading: builtTile.icon,  //icon
          title: Row(
            children: <Widget>[
              builtTile.leftColumn,
              Expanded(
                child: Container(),
              ),
              builtTile.rightColumn,    //right column
            ],
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                builtTile.expandMenu,
                builtTile.devMenu,
              ],
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}
