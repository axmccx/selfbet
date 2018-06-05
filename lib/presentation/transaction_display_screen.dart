import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfbet/models/models.dart';

class TransactionDisplayScreen extends StatelessWidget {
  final BetTransact transaction;
  final String uid;
  final List<UserEntity> members;

  TransactionDisplayScreen({
    @required this.transaction,
    @required this.uid,
    @required this.members,
  });

  Widget getLabelText() {
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

  Widget getAmount() {
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

  Widget getBetOwner() {
    if (transaction.isWon) {
      return Text('Congratulations! You won this bet!');
    } else if (!transaction.isWon && transaction.uid == uid) {
      return Text('You lost this bet!');
    } else {
      return Text('${members[0].name} lost this best');
    }
  }

  Widget getReceiversList() {
    if (transaction.isWon) {
      return Container();
    } else if (!transaction.isWon && transaction.uid == uid) {
      return Container();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
            child: Row(
              children: <Widget>[
                getLabelText(),
                Expanded(
                  child: Container(),
                ),
                getAmount(),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Group: ${transaction.groupName}"),
                Text("Transfer Date: ${DateFormat.yMMMMd().format(transaction.date)}"),
                Text("Bet Amount: \$${(transaction.amount/100).toStringAsFixed(2)}"),
                Padding(padding: EdgeInsets.all(5.0)),
                getBetOwner(),
                Padding(padding: EdgeInsets.all(5.0)),
                (!transaction.isWon) ? Text("Recipients:") : Container(),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index != 0) {
                  return _UserRow(
                      members[index],
                      uid,
                      transaction.calcedAtStake[members[index].uid]
                  );
                } else {
                  return Container();
                }
              },
              itemCount: members.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final UserEntity user;
  final String uid;
  final int calcedAtStake;

  const _UserRow(this.user, this.uid, this.calcedAtStake);

  @override
  Widget build(BuildContext context) {
    double amountTrans = user.amountTrans / 100;
    double atStake = calcedAtStake / 100;
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: Text(user.name[0]),
          ),
          title: Row(
            children: <Widget>[
              (user.uid == uid) ? Text("You") : Text(user.name),
              Expanded(
                child: Container(),
              ),
              Text("\$${amountTrans.toStringAsFixed(2)}"),
            ],
          ),
          subtitle: Text("At stake when lost: \$${atStake.toStringAsFixed(2)}"),
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
