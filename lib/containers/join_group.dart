import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/presentation/group_form_screen.dart';

class JoinGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnSaveCallBack>(
      converter: (Store<AppState> store) {
        return (context, scaffoldKey, groupName) {
          _onComplete() {
            Navigator.pop(context);
          }
          _onFail(error) {
            final snackBar = SnackBar(
              content: Text(error),
            );
            scaffoldKey.currentState.showSnackBar(snackBar);
          }
          store.dispatch(JoinGroupAction(
            groupName,
            _onComplete,
            _onFail,
          ));
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

