import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/presentation/login_new_acc_screen.dart';

class ShowLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return LoginNewAccScreen(
          onSubmit: vm.login,
          onSwitchForm: vm.moveToRegister,
          newAccount: false,
        );
      }
    );
  }
}

class _ViewModel {
  final Function(String email, String password) login;
  final Function moveToRegister;

  _ViewModel({
    @required this.login,
    @required this.moveToRegister,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      login: (email, pass) {
        store.dispatch(LogInAction(email, pass));
      },
      moveToRegister: () {
        store.dispatch(MoveToRegisterAction());
      } ,
    );
  }
}
