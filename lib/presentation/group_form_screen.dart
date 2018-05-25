import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

typedef OnSaveCallBack = Function(BuildContext, GlobalKey<ScaffoldState>, String);

class GroupFormScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final _groupNameKey = GlobalKey<FormFieldState<String>>();
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  final bool isNewGroup;
  final OnSaveCallBack onSave;

  GroupFormScreen({
    @required this.isNewGroup,
    @required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return new Scaffold(
      key: _scaffoldKey,
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
                        context,
                        _scaffoldKey,
                        _groupNameKey.currentState.value
                    );
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


