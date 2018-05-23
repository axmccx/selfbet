import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/presentation/group_owner_change_screen.dart';

class GroupOwnerChangeContainer extends StatelessWidget {
  final Group group;

  GroupOwnerChangeContainer(this.group);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return GroupOwnerChangeScreen(
          group: group,
          members: vm.groupMembers,
          onSelect: (newOwner) {
            vm.onNewOwnerSelected(group.name, newOwner);
          }
        );
      },
    );
  }
}

class _ViewModel {
  final List<UserEntity> groupMembers;
  final Function(String, String) onNewOwnerSelected;

  _ViewModel ({
    @required this.groupMembers,
    @required this.onNewOwnerSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      groupMembers: store.state.groupMembers,
      onNewOwnerSelected: (groupName, newOwner) {
        store.dispatch(ChangeGroupOwnerAction(groupName, newOwner));
      }
    );
  }
}
