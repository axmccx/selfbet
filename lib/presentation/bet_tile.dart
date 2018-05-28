import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/bet_tile_builder.dart';

class BetTile extends StatelessWidget {
  final Bet bet;
  final Function onExpireBet;   //temp function for testing
  final Function onDeleteBet;
  final Function onRenewBet;

  BetTile({
    @required this.bet,
    @required this.onExpireBet,
    @required this.onDeleteBet,
    @required this.onRenewBet,
  });

  @override
  Widget build(BuildContext context) {
    BetTileBuilder builtTile = BetTileBuilder(
        bet: bet,
        onExpireBet: onExpireBet,
        onDeleteBet: onDeleteBet,
        onRenewBet: onRenewBet,
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
            Padding(padding: EdgeInsets.all(10.0)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: builtTile.actions,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
          ],
        ),
        Divider(),
      ],
    );
  }
}
