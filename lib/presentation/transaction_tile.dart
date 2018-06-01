import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';

class TransactionTile extends StatelessWidget {
  final BetTransact transaction;
  final Function onTap;
  final String uid;

  TransactionTile({
    @required this.transaction,
    @required this.onTap,
    @required this.uid,
  });

  String getTypeText(BetTransact transaction) {
    if (transaction.isWon) {
      return 'Won!';
    } else if (!transaction.isWon && transaction.uid == uid) {
      return 'Lost!';
    } else {
      return 'Received!';
    }
  }

  Widget getAmount(BetTransact transaction) {
    if (transaction.isWon) {
      return Container();
    } else if (!transaction.isWon && transaction.uid == uid) {
      final double amount = (transaction.amount/100);
      return Text(
        "\$${amount.toStringAsFixed(2)}",
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      final double amount = ((transaction.recipients)[uid]/100);
      return Text(
        "\$${amount.toStringAsFixed(2)}",
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double amount = transaction.amount / 100;
    return Column(
      children: <Widget>[
        ListTile(
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${transaction.date}",
                  ),
                  Text(
                    getTypeText(transaction),
                  ),
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
        ),
        Divider(),
      ],
    );
  }
}
