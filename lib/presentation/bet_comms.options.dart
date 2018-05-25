import 'package:flutter/material.dart';

class BetCommsOptions extends StatefulWidget {
  @override
  _BetCommsOptionsState createState() => new _BetCommsOptionsState();
}

class _BetCommsOptionsState extends State<BetCommsOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Communication type bets not yet supported",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          Padding(padding: EdgeInsets.all(20.0)),
        ],
    );
  }
}
