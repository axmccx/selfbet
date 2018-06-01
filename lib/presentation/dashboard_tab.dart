import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'transaction_list.dart';

class DashboardTab extends StatelessWidget {
  final int balance;
  final int atStake;
  final List<BetTransact> betTransacts;
  final String uid;

  DashboardTab({
    @required this.balance,
    @required this.atStake,
    @required this.betTransacts,
    @required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    double realBalance = balance / 100;
    double realAtStake = atStake / 100;
    return Container(
      //padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Balance:   \$${realBalance.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  "At Stake:   \$${realAtStake.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          Text("   Transaction history:"),
          TransactionList(
            betTransacts: betTransacts,
            uid: uid,
          ),
        ],
      ),
    );
  }
}
