import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';

class ActiveLoginForm extends StatelessWidget {
  final ViewModelBuilder<FormType> builder;

  ActiveLoginForm({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FormType>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.formType,
      builder: builder,
    );
  }
}
