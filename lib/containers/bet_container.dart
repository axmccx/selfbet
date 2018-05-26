import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/bet_list.dart';

class BetsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BetList(
          bets: vm.bets,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Bet> bets;

  _ViewModel({
    @required this.bets,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      bets: store.state.bets,
    );
  }
}