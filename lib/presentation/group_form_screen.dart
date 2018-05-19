import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';

class GroupFormScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final _groupNameKey = GlobalKey<FormFieldState<String>>();

  final bool isNewGroup;
  final Function(String) onSave;

  GroupFormScreen({
    @required this.isNewGroup,
    @required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return new Scaffold(
      appBar: AppBar(
        title: Text(
          isNewGroup ? "Create Group" : "Join Group",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                key: _groupNameKey,
                autofocus: true,
                style: textTheme.headline,
                decoration: InputDecoration(
                  labelText: "Group Name",
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'Please enter a group name'
                      : null;
                },
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    onSave(
                      _groupNameKey.currentState.value,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
