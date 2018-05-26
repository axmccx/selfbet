import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/group_list.dart';
import 'package:selfbet/containers/containers.dart';


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
  final Function(BuildContext, Group) showMembers;

  _ViewModel({
    @required this.groups,
    @required this.showMembers,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      groups: store.state.groups,
      showMembers: (context, group) {
        store.dispatch(GetGroupMembersAction(
            groupMemberUids: group.members,
            callBack: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return GroupDisplayContainer(group);
                },
              ));
            },
        ));
      },
    );
  }
}