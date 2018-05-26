import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:selfbet/models/models.dart';

class BetTile extends StatelessWidget {
  final Bet bet;

  BetTile({
    @required this.bet,
  });

  Icon getIcon() {
    switch(bet.type) {
      case BetType.alarmClock: {
        return Icon(Icons.alarm);
      }
      case BetType.comms: {
        return Icon(Icons.contact_phone);
      }
      case BetType.location: {
        return Icon(Icons.location_on);
      }
      case BetType.mock: {
        return Icon(Icons.input);
      }
      default: {
        return Icon(Icons.input);
      }
    }
  }

  Text getExpiryLine() {
    if (bet.isExpired) {
      return Text(
          "EXPIRED",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w400,
        ),
      );
    } else {
      return Text("Expires: " + DateFormat.MMMEd().format(bet.expiryDate));
    }
  }

  Column getOptions() {
    switch(bet.type) {
      case BetType.alarmClock: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Time: ${bet.options['hour']}:${bet.options['minutes']}"),
            Text("Snoozes Left: ${bet.options['frequency']}"),
          ],
        );
      }
      case BetType.comms: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(),
          ],
        );
      }
      case BetType.location: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Progress: 0/2"),
          ],
        );
      }
      case BetType.mock: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mock"),
          ],
        );
      }
      default: {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mock"),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double amount = bet.amount / 100;
    return new Column(
      children: <Widget>[
        ExpansionTile(
          leading: getIcon(),
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Amount \$${amount.toStringAsFixed(2)}"),
                  Text("Group: ${bet.groupName}"),
                  getExpiryLine(),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              getOptions(),
            ],
          ),
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 20.0,
                ),
                RaisedButton(
                  child: Text("Renew"),
                  onPressed: () { debugPrint("Renew Bet!"); },
                ),
                Container(
                  width: 30.0,
                ),
                RaisedButton(
                  child: Text("Delete"),
                  onPressed: () { debugPrint("Delete Bet!"); },
                ),
                Container(
                  width: 30.0,
                ),
                RaisedButton(
                  child: Text("Expire*"),
                  onPressed: () { debugPrint("Expire Bet!"); },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
          ],
        ),
        Divider(),
      ],
    );
  }
}
