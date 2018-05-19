import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DashboardTab extends StatelessWidget {
  final int balance;
  final int atStake;

  DashboardTab({
    @required this.balance,
    @required this.atStake,
  });

  @override
  Widget build(BuildContext context) {
    double realBalance = balance / 100;
    double realAtStake = atStake / 100;
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Balance:   \$${realBalance.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ),
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
    );
  }
}
