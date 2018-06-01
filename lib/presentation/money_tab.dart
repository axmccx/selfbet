import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MoneyTab extends StatelessWidget {
  final String name;
  final Function callback;

  MoneyTab({
    @required this.name,
    @required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: RaisedButton(
              onPressed: callback,
              child: Text(
                "Credit Faucet",
                style: TextStyle(
                    fontSize: 20.0
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(30.0)),
          Text("Currently logged in as: \n$name"),
        ],
      ),
    );
  }
}
