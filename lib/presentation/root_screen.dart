import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';
import 'package:selfbet/presentation/home_screen.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.user == null) {
          if (vm.formType == FormType.login) {
            return ShowLogin();
          } else {
            return ShowNewAcc();
          }
        } else {
          return HomeScreen(vm.isLoading, vm.groups, vm.balance);
        }
      },
    );
  }
}

class _ViewModel {
  final FormType formType;
  final FirebaseUser user;
  final bool isLoading;
  final List<Group> groups;
  final int balance;

  _ViewModel({
    @required this.formType,
    @required this.user,
    @required this.isLoading,
    @required this.groups,
    @required this.balance,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      formType: store.state.formType,
      user: store.state.currentUser,
      isLoading: store.state.isLoading,
      groups: store.state.groups,
      balance: store.state.balance,
    );
  }
}