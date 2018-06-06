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
            List<Bet> expiredBetInGroup = vm.bets.where((bet) {
              return (bet.groupName == group.name) && bet.isExpired;
            }).toList();
            if (action == ExtraActions.LeaveGroup) {
              List<Bet> activeBetInGroup = vm.bets.where((bet) {
                return (bet.groupName == group.name) && !bet.isExpired;
              }).toList();
              if (activeBetInGroup.length > 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        content: Text(
                          "You can't leave this group, you have active bets in it!",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                        ],
                      ),
                );
              } else if (group.members.length < 3 && group.groupAtStake > 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        content: Text(
                          "You can't leave this group, the only other member has active bets. "
                              "You could earn money if they lose!",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                        ],
                      ),
                );
              } else if (expiredBetInGroup.length > 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        content: Text(
                          "Leave group?\nThis will delete all the expired bets assigned to this group",
                        ),
                        actions: <Widget>[
                          FlatButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          new FlatButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                                expiredBetInGroup.forEach((bet) {
                                  vm.onDeleteBet(bet);
                                });
                                vm.leaveGroupDispatch(group.name);
                              }
                          ),
                        ],
                      ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        content: Text(
                          "Leave group?",
                        ),
                        actions: <Widget>[
                          FlatButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          FlatButton(
                              child: const Text('LEAVE'),
                              onPressed: () {
                                Navigator.pop(context);
                                vm.leaveGroupDispatch(group.name);
                              }
                          )
                        ],
                      ),
                );
              }
            }
            if (action == ExtraActions.DeleteGroup) {
              if (expiredBetInGroup.length > 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        content: Text(
                          "Delete group?\nThis will delete all the expired bets assigned to this group",
                        ),
                        actions: <Widget>[
                          FlatButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          new FlatButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                                expiredBetInGroup.forEach((bet) {
                                  vm.onDeleteBet(bet);
                                });
                                vm.deleteGroupDispatch(group.name);
                              }
                          ),
                        ],
                      ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        content: Text(
                          "Delete group?",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          new FlatButton(
                              child: const Text('DELETE'),
                              onPressed: () {
                                Navigator.pop(context);
                                vm.deleteGroupDispatch(group.name);
                              }
                          )
                        ],
                      ),
                );
              }
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
  final List<Bet> bets;
  final Function(BuildContext, Group) changeGroupOwnerDispatch;
  final Function(String) leaveGroupDispatch;
  final Function(String) deleteGroupDispatch;
  final Function(Bet) onDeleteBet;

  _ViewModel({
    @required this.name,
    @required this.bets,
    @required this.changeGroupOwnerDispatch,
    @required this.leaveGroupDispatch,
    @required this.deleteGroupDispatch,
    @required this.onDeleteBet,
  });

  static _ViewModel fromStore(Store <AppState> store) {
    return _ViewModel(
      name: store.state.name,
      bets: store.state.bets,
      changeGroupOwnerDispatch: (context, group) {
        store.dispatch(GetGroupMembersAction(
            groupMemberUids: group.members,
            callBack: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return GroupOwnerChangeContainer(group.name);
                },
              ));
            },
        ));
      },
      leaveGroupDispatch: (groupName) {
        store.dispatch(LeaveGroupAction(groupName));
      },
      deleteGroupDispatch: (groupName) {
        store.dispatch(DeleteGroupAction(groupName));
      },
      onDeleteBet: (bet) {
        store.dispatch(DeleteBetAction(bet));
      },
    );
  }
}