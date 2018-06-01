import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/transaction_tile.dart';

class TransactionList extends StatelessWidget {
  final List<BetTransact> betTransacts;
  final String uid;

  TransactionList({
    @required this.betTransacts,
    @required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: betTransacts.length,
        itemBuilder: (BuildContext context, int index) {
          final transaction = betTransacts[index];
          return TransactionTile(
            transaction: transaction,
            onTap: null,
            uid: uid,
          );
        },
      ),
    );
  }
}

