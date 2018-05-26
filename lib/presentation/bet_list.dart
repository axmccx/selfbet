import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/bet_tile.dart';


class BetList extends StatelessWidget {
  final List<Bet> bets;

  BetList({
    @required this.bets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bets.length,
      itemBuilder: (BuildContext context, int index) {
        final bet = bets[index];
        return BetTile(
          bet: bet,
        );
      },
    );
  }
}
