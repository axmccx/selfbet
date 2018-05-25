import 'package:flutter/material.dart';

class BetLocationOptions extends StatefulWidget {
  @override
  _BetLocationOptionsState createState() => new _BetLocationOptionsState();
}

class _BetLocationOptionsState extends State<BetLocationOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Location type bets not yet supported",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        Padding(padding: EdgeInsets.all(20.0)),
      ],
    );
  }
}
