import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/group_popup_menu.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/containers/containers.dart';

class GroupPopupMenuContainer extends StatelessWidget {
  final Group group;

  GroupPopupMenuContainer(this.group);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
    converter: _ViewModel.fromStore,
    builder: (context, vm) {
      return GroupPopupMenu(
          onSelected: (action) {
            if (action == ExtraActions.ChangeGroupOwner) {
              vm.changeGroupOwnerDispatch(context, group);
            }
            if (action == ExtraActions.LeaveGroup) {
              debugPrint("LeaveGroup");
            }
            if (action == ExtraActions.DeleteGroup) {
              debugPrint("DeleteGroup");
            }
          },
          canChangeOwner: (vm.name == group.owner) &&
              (group.members.length > 1),
          canLeaveGroup: (vm.name != group.owner) &&
              (group.members.length > 1),
          canDeleteGroup: (vm.name == group.owner) &&
          (group.members.length == 1),
      );
    });
  }
}

class _ViewModel {
  final String name;
  final Function(BuildContext, Group) changeGroupOwnerDispatch;

  _ViewModel({
    @required this.name,
    @required this.changeGroupOwnerDispatch,
  });

  static _ViewModel fromStore(Store <AppState> store) {
    return _ViewModel(
      name: store.state.name,
      changeGroupOwnerDispatch: (context, group) {
        store.dispatch(GetGroupMembersAction(
            groupMemberUids: group.members,
            callBack: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return GroupOwnerChangeContainer(group);
                },
              ));
            },
        ));
      },
    );
  }
}