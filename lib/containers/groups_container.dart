import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
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
          //showMembers: vm.showMembers,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Group> groups;
  final bool loading;
//  final Function(Group) showMembers;
//  final Function(Group) leaveGroup;
//  final Function(Group) changeOwner;

  _ViewModel({
    @required this.groups,
    @required this.loading,
//    @required this.showMembers,
//    @required this.leaveGroup,
//    @required this.changeOwner,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      groups: [
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
        Group(
          name: "Test Group",
          owner: "Alex M.",
          groupAtStake: 5,
          members: [],
        ),
      ],
      loading: store.state.isLoading,
//      showMembers: (group) => debugPrint("Group: \"${group.name}\" shows the members"),
//      leaveGroup: (group) => debugPrint("User leaves the group"),
//      changeOwner: (group) => debugPrint("Allow the user to pick a new owner"),
    );
  }
}