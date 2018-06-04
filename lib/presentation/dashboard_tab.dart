import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';
import 'package:selfbet/presentation/loading_indicator.dart';
import 'package:selfbet/presentation/transaction_list.dart';

class DashboardTab extends StatelessWidget {
  final int balance;
  final int atStake;
  final List<BetTransact> betTransacts;
  final String uid;
  final Function showBetTransact;

  DashboardTab({
    @required this.balance,
    @required this.atStake,
    @required this.betTransacts,
    @required this.uid,
    @required this.showBetTransact,
  });

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return Stack(
        children: <Widget>[
          _buildDashboardTab(),
          Align(
            child: loading ? LoadingIndicator("Loading") : Container(),
            alignment: FractionalOffset.center,
          ),
        ],
      );
    });
  }

  Widget _buildDashboardTab() {
    double realBalance = balance / 100;
    double realAtStake = atStake / 100;
    return Container(
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
            showBetTransact: showBetTransact,
          ),
        ],
      ),
    );
  }
}
