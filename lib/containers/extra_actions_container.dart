import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/presentation/extra_actions_button.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/auth_actions.dart';

class ExtraActionsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ExtraActionsButton(
          onSelected: vm.onActionSelected,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(ExtraActions) onActionSelected;

  _ViewModel ({
    @required this.onActionSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onActionSelected: (action) {
        if (action == ExtraActions.LogOut) {
          store.dispatch(LogOutAction());
        }
      }
    );
  }
  // Might need to add == and hashcode overrides
}