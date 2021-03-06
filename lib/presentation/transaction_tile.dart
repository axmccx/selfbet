import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:selfbet/models/models.dart';

class TransactionTile extends StatelessWidget {
  final BetTransact transaction;
  final Function(BuildContext, BetTransact, String) onTap;
  final String uid;

  TransactionTile({
    @required this.transaction,
    @required this.onTap,
    @required this.uid,
  });

  Widget getLabelText(BetTransact transaction) {
    if (transaction.isWon) {
      return Text(
        'WON',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (!transaction.isWon && transaction.uid == uid) {
      return Text(
        'LOST',
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return Text(
        'RECEIVED',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
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
    return Column(
      children: <Widget>[
        ListTile(
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${DateFormat.yMMMMd().format(transaction.date)}",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  getLabelText(transaction),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Column(
                children: <Widget>[
                  getAmount(transaction),
                ],
              ),
            ],
          ),
          onTap: () { onTap(context, transaction, uid); },
        ),
        Divider(),
      ],
    );
  }
}
