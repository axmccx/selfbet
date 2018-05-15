import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActiveLoginForm(
      builder: (BuildContext context, FormType form) {
        if (form == FormType.login) {
          return ShowLogin();
        } else {
          return ShowNewAcc();
        }
      },
    );
  }
}
