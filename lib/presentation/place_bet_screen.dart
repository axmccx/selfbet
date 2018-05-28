import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/bet_alarm_options.dart';
import 'package:selfbet/presentation/bet_comms.options.dart';
import 'package:selfbet/presentation/bet_location_options.dart';

typedef OnBetSubmit = Function(int, BetType, String, Map);

class PlaceBetScreen extends StatefulWidget {
  final int balance;
  final List<Group> groups;
  final OnBetSubmit onSubmit;

  PlaceBetScreen({
    @required this.balance,
    @required this.groups,
    @required this.onSubmit,
  });

  @override
  _PlaceBetScreenState createState() => new _PlaceBetScreenState();
}

class _PlaceBetScreenState extends State<PlaceBetScreen> {
  static final _formKey = GlobalKey<FormState>();
  static final _alarmOptionsKey = GlobalKey<BetAlarmOptionsState>();

  int _selectAmount;
  String _selectedGroupName;
  BetType _selectedType;
  Map _selectedOptions;

  Widget betOptions(BetType type) {
    switch(type) {
      case BetType.comms: {
        return BetCommsOptions();
      }
      case BetType.alarmClock: {
        return BetAlarmOptions(key: _alarmOptionsKey);
      }
      case BetType.location: {
        return BetLocationOptions();
      }
      default: {
        return Container();
      }
    }
  }

  setSelectedOptions() {
    switch(_selectedType) {
      case BetType.comms: {
        break;
      }
      case BetType.alarmClock: {
        _selectedOptions = _alarmOptionsKey.currentState.getOptionsMap();
        break;
      }
      case BetType.location: {
        break;
      }
      default: {
        break;
      }
    }
  }

  Function _submit(BuildContext context) {
    if ((_selectedType == BetType.location) ||
        (_selectedType == BetType.comms)) {
      return () {
        final snackBar = SnackBar(
          content: Text("Selected bet type not supported"),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      };
    } else if (_selectedGroupName == null) {
      return () {
        final snackBar = SnackBar(
          content: Text("Please select a group"),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      };
    } else if (_selectedType == null) {
      return () {
        final snackBar = SnackBar(
          content: Text("Please select a bet type"),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      };
    } else {
      return () {
        final form = _formKey.currentState;
        if (form.validate()) {
          form.save();
          setSelectedOptions();
          widget.onSubmit(
            _selectAmount,
            _selectedType,
            _selectedGroupName,
            _selectedOptions,
          );
          Navigator.pop(context);
        }
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Bet"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text("I bet"),
              Row(
                children: <Widget>[
                  Text(
                    "Amount: \$ ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    width: 80.0,
                    height: 45.0,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        try {
                          if (val.isEmpty) { return 'Empty!'; }
                          final num = double.parse(val);
                          if (num < 1) { return 'Must be >= 1'; }
                          debugPrint((val.length).toString() );
                          if (val.length > 5) { return 'Invalid'; }
                          if ((double.parse(val) * 100).round()
                              > widget.balance) {
                            return 'Too much!';
                          }
                          return null;
                        } on FormatException {
                          return 'Invalid';
                        }
                      },
                      onSaved: (val) =>
                        _selectAmount = (double.parse(val) * 100).round(),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Text("with my friends in "),
              Row(
                children: <Widget>[
                  Text(
                    "Group: ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      value: _selectedGroupName,
                      items: widget.groups.map((group) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            group.name,
                          ),
                          value: group.name,
                        );
                      }).toList(),
                      onChanged: (String groupName) {
                        setState(() {
                          _selectedGroupName = groupName;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Text(getTypeMsg(_selectedType)),
              Row(
                children: <Widget>[
                  Text(
                    "Type: ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: DropdownButton<BetType>(
                      value: _selectedType,
                      items: BetType.values.map((type) {
                        return DropdownMenuItem<BetType>(
                          child: Text(
                            typeToString(type),
                          ),
                          value: type,
                        );
                      }).toList(),
                      onChanged: (BetType type) {
                        setState(() {
                          _selectedType = type;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              betOptions(_selectedType),
              Builder(
                builder: (BuildContext context) {
                  return RaisedButton(
                    onPressed: _submit(context),
                    child: Text("Submit"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
