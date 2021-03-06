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
          isLoading: vm.isLoading,
          newAccount: false,
        );
      }
    );
  }
}

class _ViewModel {
  final OnLoginCallBack login;
  final Function(GlobalKey<FormState>) moveToRegister;
  final bool isLoading;

  _ViewModel({
    @required this.login,
    @required this.moveToRegister,
    @required this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      login: (context, scaffoldKey, email, pass, name) {
        _onLoginFail() {
          final snackBar = SnackBar(
            content: Text("Authentication Error"),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }
        store.dispatch(LogInAction(email, pass, _onLoginFail));
      },
      moveToRegister: (formKey) {
        formKey.currentState.reset();
        store.dispatch(MoveToRegisterAction());
      },
      isLoading: store.state.isLoading,
    );
  }
}
