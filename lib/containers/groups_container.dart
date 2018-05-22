import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/group_list.dart';


class GroupsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return GroupList(
          groups: vm.groups,
          showMembers: vm.showMembers,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Group> groups;
  final bool loading;
  final Function(BuildContext, Group) showMembers;
//  final Function(Group) leaveGroup;
//  final Function(Group) changeOwner;

  _ViewModel({
    @required this.groups,
    @required this.loading,
    @required this.showMembers,
//    @required this.leaveGroup,
//    @required this.changeOwner,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      groups: store.state.groups,
      loading: store.state.isLoading,
      showMembers: (context, group) {
        store.dispatch(GetGroupMembersAction(
            context,
            group,
            group.members
        ));
      },
//      leaveGroup: (group) => debugPrint("User leaves the group"),
//      changeOwner: (group) => debugPrint("Allow the user to pick a new owner"),
    );
  }
}