import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:intl/intl.dart';

class BetTileBuilder {
  final Bet bet;
  double amount;
  Icon icon;
  Widget leftColumn;
  Widget rightColumn;
  List<Widget> actions;


  BetTileBuilder(this.bet) {
    amount = bet.amount / 100;
    leftColumn = _buildLeftCol();
    switch(bet.type) {
      case BetType.alarmClock: {
        icon = Icon(Icons.alarm);
        rightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Time: ${bet.options['hour']}:${bet.options['minutes']}"),
            Text("Snoozes Left: ${bet.options['frequency']}"),
          ],
        );
        actions = []..addAll(_defaultActions())..add(
          RaisedButton(
            child: Text("Snooze*"),
            onPressed: bet.isExpired
                ? null
                : () { debugPrint("Snoozing alarm!"); },
          ),
        );
        break;
      }
      case BetType.comms: {
        icon = Icon(Icons.contact_phone);
        rightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(),
          ],
        );
        actions = []..addAll(_defaultActions());
        break;
      }
      case BetType.location: {
        icon = Icon(Icons.location_on);
        rightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Progress: 0/2"),
          ],
        );
        actions = []..addAll(_defaultActions());
        break;
      }
      case BetType.mock: {
        icon = Icon(Icons.input);
        rightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mock"),
          ],
        );
        actions = []..addAll(_defaultActions())..add(
          RaisedButton(
            child: Text("Expire*"),
            onPressed: bet.isExpired
                ? null
                : () { debugPrint("Expire Bet!"); },
          ),
        );
        break;
      }
      default: {
        icon = Icon(Icons.input);
        rightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mock"),
          ],
        );
        break;
      }
    }
  }

  Widget _buildLeftCol () {
    return Column(         // left column
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Amount \$${amount.toStringAsFixed(2)}"),
        Text("Group: ${bet.groupName}"),
        _getExpiryLine(),
      ],
    );
  }

  Text _getExpiryLine() {
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

  List<Widget> _defaultActions() {
    return [
      Container(
        width: 20.0,
      ),
      RaisedButton(
        child: Text("Renew"),
        onPressed: bet.isExpired
            ? () { debugPrint("Renew Bet!"); }
            : null,
      ),
      Container(
        width: 30.0,
      ),
      RaisedButton(
        child: Text("Delete"),
        onPressed: bet.isExpired
            ? () { debugPrint("Delete Bet!"); }
            : null,
      ),
      Container(
        width: 60.0,
      ),
    ];
  }
}