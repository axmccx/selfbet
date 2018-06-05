import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:intl/intl.dart';

class BetTileBuilder {
  final Bet bet;
  final Function(Bet) onExpireBet;
  final Function(Bet) onWinBet;
  final Function(Bet) onDeleteBet;
  final Function(Bet) onRenewBet;
  final Function(Bet) onSnoozeAlarmBet;
  double amount;
  Icon icon;
  Widget leftColumn;
  Widget rightColumn;
  Widget expandMenu;
  Widget devMenu;


  BetTileBuilder({
    @required this.bet,
    @required this.onExpireBet,
    @required this.onWinBet,
    @required this.onDeleteBet,
    @required this.onRenewBet,
    @required this.onSnoozeAlarmBet,
  }) {
    amount = bet.amount / 100;
    rightColumn = _getStatusLabel();
    expandMenu = Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Group: ${bet.groupName}",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          _getExpiryLine(),
          Padding(padding: EdgeInsets.all(5.0)),
          _defaultActions(),
        ],
      ),
    );
    switch(bet.type) {
      case BetType.alarmClock: {
        icon = Icon(Icons.alarm);
        leftColumn = Column(         // left column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Amount \$${amount.toStringAsFixed(2)}"),
            Text("Time: ${bet.options['hour']}:${bet.options['minutes']}"),
            Text("Snoozes Left: "
                "${bet.options['count']}/${bet.options['frequency']}"),
          ],
        );
        devMenu = Container(
          margin: EdgeInsets.fromLTRB(20.0,  0.0, 20.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dev options",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Expire"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onExpireBet(bet); },
                  ),
                  Container(
                    width: 30.0,
                  ),
                  RaisedButton(
                    child: Text("Snooze"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onSnoozeAlarmBet(bet); },
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      }
      case BetType.comms: {
        icon = Icon(Icons.contact_phone);
        leftColumn = Column(         // left column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Amount \$${amount.toStringAsFixed(2)}"),
            Text("Contact Count: 0"),
          ],
        );
        devMenu = Container(
          margin: EdgeInsets.fromLTRB(20.0,  0.0, 20.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dev options",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Expire"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onExpireBet(bet); },
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      }
      case BetType.location: {
        icon = Icon(Icons.location_on);
        leftColumn = Column(         // left column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Amount \$${amount.toStringAsFixed(2)}"),
            Text("Visit Count: 0"),
          ],
        );
        devMenu = Container(
          margin: EdgeInsets.fromLTRB(20.0,  0.0, 20.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dev options",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Expire"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onExpireBet(bet); },
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      }
      case BetType.mock: {
        icon = Icon(Icons.input);
        leftColumn = Column(         // left column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Amount \$${amount.toStringAsFixed(2)}"),
            Text("Mock \nIncrement Bet"),
          ],
        );
        devMenu = Container(
          margin: EdgeInsets.fromLTRB(20.0,  0.0, 20.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dev options",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Expire"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onExpireBet(bet); },
                  ),
                  Container(
                    width: 30.0,
                  ),
                  RaisedButton(
                    child: Text("Win"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onWinBet(bet); },
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      }
      default: {
        icon = Icon(Icons.input);
        leftColumn = Column(         // left column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Amount \$${amount.toStringAsFixed(2)}"),
            Text("Mock \nIncrement Bet"),
          ],
        );
        devMenu = Container(
          margin: EdgeInsets.fromLTRB(20.0,  0.0, 20.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dev options",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Expire"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onExpireBet(bet); },
                  ),
                  Container(
                    width: 30.0,
                  ),
                  RaisedButton(
                    child: Text("Win"),
                    onPressed: bet.isExpired
                        ? null
                        : () { onWinBet(bet); },
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      }
    }
  }

  Widget _getStatusLabel() {
    Widget label;
    if (!bet.isExpired) {
      label = Text(
        "Active",
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.blueAccent,
        ),
      );
    }
    if (bet.isExpired && bet.winCond) {
      label = Text(
        "Won!",
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    if (bet.isExpired && !bet.winCond) {
      label = Text(
        "Lost!",
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.redAccent,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        label,
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

  Widget _defaultActions() {
    return Row(
      children: <Widget>[
        RaisedButton(
          child: Text("Renew"),
          onPressed: bet.isExpired
              ? () { onRenewBet(bet); }
              : null,
        ),
        Container(
          width: 30.0,
        ),
        RaisedButton(
          child: Text("Delete"),
          onPressed: bet.isExpired
              ? () { onDeleteBet(bet); }
              : null,
        ),
        Container(
          width: 60.0,
        ),
      ],
    );
  }
}