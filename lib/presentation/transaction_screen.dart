import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfbet/models/models.dart';

class TransactionScreen extends StatelessWidget {
  final BetTransact transaction;
  final String uid;

  TransactionScreen(this.transaction, this.uid);

  Widget getLabelText(BetTransact transaction) {
    if (transaction.isWon) {
      return Text(
        'WON',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w500,
          fontSize: 24.0,
        ),
      );
    } else if (!transaction.isWon && transaction.uid == uid) {
      return Text(
        'LOST',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w500,
          fontSize: 24.0,
        ),
      );
    } else {
      return Text(
        'RECEIVED',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
          fontSize: 24.0,
        ),
      );
    }
  }

  Widget getAmount(BetTransact transaction) {
    if (transaction.isWon) {
      return Container();
    } else if (!transaction.isWon && transaction.uid == uid) {
      final double amount = (transaction.amount/100);
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
      );
    } else {
      final double amount = (transaction.recipients[uid]/100);
      return Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                getLabelText(transaction),
                Expanded(
                  child: Container(),
                ),
                getAmount(transaction),
              ],
            ),
            Divider(),
            Text("Group: ${transaction.groupName}"),
            Text("Date: ${DateFormat.yMMMMd().format(transaction.date)}"),
            Text("Bet Amount: \$${(transaction.amount/100).toStringAsFixed(2)}"),
            Padding(padding: EdgeInsets.all(5.0)),
            Text("Who placed the bet: \n${transaction.uid}"),
            Padding(padding: EdgeInsets.all(5.0)),
            Text("Recipients: \n${transaction.recipients}"),
          ],
        ),
      ),
    );
  }
}
