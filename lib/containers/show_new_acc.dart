import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/presentation/login_new_acc_screen.dart';

class ShowNewAcc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return LoginNewAccScreen(
          onSubmit: vm.createAccount,
          onSwitchForm: vm.moveToLogin,
          isLoading: vm.isLoading,
          newAccount: true,
        );
      }
    );
  }
}

class _ViewModel {
  final OnLoginCallBack createAccount;
  final Function(GlobalKey<FormState>) moveToLogin;
  final bool isLoading;

  _ViewModel({
    @required this.createAccount,
    @required this.moveToLogin,
    @required this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      createAccount: (context, scaffoldKey, email, pass, name) {
        _onLoginFail() {
          final snackBar = SnackBar(
            content: Text("Authentication Error\n This email may be already used. Contact Alex."),
            duration: Duration(seconds: 4),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }
        store.dispatch(CreateAccountAction(email, pass, name, _onLoginFail));
      },
      moveToLogin: (formKey) {
        formKey.currentState.reset();
        store.dispatch(MoveToLoginAction());
      },
      isLoading: store.state.isLoading,
    );
  }
}