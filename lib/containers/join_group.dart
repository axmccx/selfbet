import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/presentation/group_form_screen.dart';

class JoinGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function(String)>(
      converter: (Store<AppState> store) {
        return (groupName) {
          store.dispatch(JoinGroupAction(groupName));
        };
      },
      builder: (context, onSave) {
        return GroupFormScreen(
          onSave: onSave,
          isNewGroup: false,
        );
      },
    );
  }
}

