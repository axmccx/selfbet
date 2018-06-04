import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/transaction_display_screen.dart';

class TransactionDisplayContainer extends StatelessWidget {
  final BetTransact transaction;
  final String uid;

  TransactionDisplayContainer(this.transaction, this.uid);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<UserEntity>>(
      converter: (Store<AppState> store) => store.state.membersOf,
      builder: (context, members) {
        return TransactionDisplayScreen(
          transaction: transaction,
          uid: uid,
          members: members,
        );
      },
    );
  }
}
