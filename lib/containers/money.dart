import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';

class Money extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(CreditFaucet());
        },
        builder: (context, callback) {
          return new Container(
            child: new RaisedButton(
              onPressed: callback,
              child: new Text("Credit Faucet"),
            ),
          );
        }
    );
  }
}