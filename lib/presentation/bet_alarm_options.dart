import 'package:flutter/material.dart';
import 'dart:async';

class BetAlarmOptions extends StatefulWidget {
  BetAlarmOptions({ Key key }) : super(key: key);

  @override
  BetAlarmOptionsState createState() => new BetAlarmOptionsState();
}

class BetAlarmOptionsState extends State<BetAlarmOptions> {
  TimeOfDay _time = TimeOfDay(hour: 6, minute: 30);
  int _selectedFreq = 0;

  Map getOptionsMap() {
    return {
      "hour": _time.hour,
      "minutes": _time.minute,
      "frequency": _selectedFreq,
      "count": _selectedFreq,
    };
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );

    if(picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState((){
        _time = picked;
      });
    }
  }

  String periodToString(DayPeriod p) {
    switch(p) {
      case DayPeriod.am: {
        return 'am';
      }
      case DayPeriod.pm: {
        return 'pm';
      }
      default:{
        return 'error';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${_time.hourOfPeriod}\:${_time.minute} "
              "${periodToString(_time.period)} each day",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        new RaisedButton(
            child: new Text('Set Alarm Time'),
            onPressed: (){_selectTime(context);}
        ),
        Padding(padding: EdgeInsets.all(20.0)),
        Text('no more than'),
        Row(
          children: <Widget>[
            Text(
              "Frequency: ",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0),
              //width: 80.0,
              child: DropdownButton<int>(
                value: _selectedFreq,
                items: [0,1,2,3].map((num) {
                  return DropdownMenuItem<int>(
                    child: Text(
                      num.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    value: num,
                  );
                }).toList(),
                onChanged: (int num) {
                  setState(() {
                    _selectedFreq = num;
                  });
                },
              ),
            ),
            Text(
              "times ",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(2.0)),
        Text(
          " in the next week.",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(padding: EdgeInsets.all(20.0)),
      ],
    );
  }
}
