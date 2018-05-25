import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/presentation/place_bet_screen.dart';

class PlaceBetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return PlaceBetScreen(
          groups: vm.groups,
          onSubmit: vm.onSubmit,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Group> groups;
  final OnBetSubmit onSubmit;

  _ViewModel({
    @required this.groups,
    @required this.onSubmit,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      groups: store.state.groups,
      onSubmit: (amount, type, groupName, options) {
        store.dispatch(PlaceBetAction(Bet(
          amount: amount,
          type: type,
          groupName: groupName,
          isExpired: false,
          expiryDate: DateTime.now().add(Duration(days: 7)),
          options: options,
        )));
      }
    );
  }
}
