import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';

class GroupOwnerChangeScreen extends StatefulWidget {
  final String groupName;
  final List<UserEntity> members;
  final Function(String) onSelect;

  GroupOwnerChangeScreen({
    @required this.groupName,
    @required this.members,
    @required this.onSelect,
  });

  @override
  _GroupOwnerChangeScreenState createState() => new _GroupOwnerChangeScreenState();
}

class _GroupOwnerChangeScreenState extends State<GroupOwnerChangeScreen> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Owner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              widget.onSelect(widget.members[_selected].name);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Choose a new owner for ${widget.groupName}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    RadioListTile<int>(
                      title: Text(widget.members[index].name),
                      value: index,
                      groupValue: _selected,
                      onChanged: (int value) {
                        setState(() {
                          _selected = value;
                        });
                      },
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: widget.members.length,
            ),
          ),
        ],
      ),
    );
  }
}