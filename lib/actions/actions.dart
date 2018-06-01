import 'dart:async';

import 'package:selfbet/models/models.dart';
import 'package:flutter/material.dart';

class InitAppAction {
  @override
  String toString() {
    return 'InitAppAction{}';
  }
}

class ConnectToDataSourceAction {
  @override
  String toString() {
    return 'ConnectToDataSourceAction{}';
  }
}

class SetUserStreamAction{
  final StreamSubscription userStream;

  SetUserStreamAction(this.userStream);

  @override
  String toString() {
    return 'SetUserStreamAction{userStream: $userStream}';
  }
}

class SetGroupStreamAction{
  final StreamSubscription groupStream;

  SetGroupStreamAction(this.groupStream);

  @override
  String toString() {
    return 'SetGroupStreamAction{groupStream: $groupStream}';
  }
}

class SetBetStreamAction{
  final StreamSubscription betStream;

  SetBetStreamAction(this.betStream);

  @override
  String toString() {
    return 'SetBetStreamAction{betStream: $betStream}';
  }
}

class SetBetTransactStreamAction{
  final StreamSubscription betTransactStream;

  SetBetTransactStreamAction(this.betTransactStream);

  @override
  String toString() {
    return 'SetBetTransactStreamAction{betTransactStream: $betTransactStream}';
  }
}

class LoadDashboardAction {
  final UserEntity userEntity;

  LoadDashboardAction(this.userEntity);

  @override
  String toString() {
    return 'LoadDashboardAction{userEntity: $userEntity}';
  }
}

class LoadGroupsAction {
  final List<Group> groups;

  LoadGroupsAction(this.groups);

  @override
  String toString() {
    return 'LoadGroupsAction{groups: $groups}';
  }
}

class GetGroupMembersAction{
  final Map groupMemberUids;
  final Function callBack;

  GetGroupMembersAction({
    @required this.groupMemberUids,
    @required this.callBack
  });

  @override
  String toString() {
    return 'GetGroupMembersAction{groupMemberUids: $groupMemberUids}';
  }
}

class LoadGroupMembersAction {
  final List<UserEntity> groupMembers;
  final Function callBack;

  LoadGroupMembersAction({
    @required this.groupMembers,
    @required this.callBack
  });

  @override
  String toString() {
    return 'LoadGroupMembersAction{groupMembers: $groupMembers}';
  }
}

class LoadBetsAction {
  final List<Bet> bets;

  LoadBetsAction(this.bets);

  @override
  String toString() {
    return 'LoadBetsAction{bets: $bets}';
  }
}

class LoadBetTransactAction {
  final List<BetTransact> betTransacts;

  LoadBetTransactAction(this.betTransacts);

  @override
  String toString() {
    return 'LoadBetTransactAction{betTransacts: $betTransacts}';
  }

}

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}

class CreditFaucetAction {
  @override
  String toString() {
    return 'CreditFaucetAction{}';
  }
}

class PlaceBetAction {
  final Bet bet;

  PlaceBetAction(this.bet);

  @override
  String toString() {
    return 'PlacebetAction{Bet: $bet}';
  }
}

class DeleteBetAction {
  final Bet bet;

  DeleteBetAction(this.bet);

  @override
  String toString() {
    return 'DeleteBetAction{}';
  }
}

class RenewBetAction {
  final Bet bet;

  RenewBetAction(this.bet);

  @override
  String toString() {
    return 'RenewBetAction{}';
  }
}

class ExpireBetAction {  //Temp action for testing
  final Bet bet;

  ExpireBetAction(this.bet);

  @override
  String toString() {
    return 'ExpireBetAction{bet: $bet}';
  }
}

class SetWinBetAction {
  final Bet bet;

  SetWinBetAction(this.bet);

  @override
  String toString() {
    return 'SetWinBetAction{bet: $bet}';
  }
}

class SnoozeAlarmBetAction {
  final Bet bet;

  SnoozeAlarmBetAction(this.bet);

  @override
  String toString() {
    return 'SnoozeAlarmBetAction{bet: $bet}';
  }
}

class CreateGroupAction {
  final Group group;
  final Function onComplete;
  final Function onFail;

  CreateGroupAction(this.group, this.onComplete, this.onFail);

  @override
  String toString() {
    return 'CreateGroupAction{group: $group}';
  }
}

class JoinGroupAction {
  final String groupName;
  final Function onComplete;
  final Function onFail;

  JoinGroupAction(this.groupName, this.onComplete, this.onFail);

  @override
  String toString() {
    return 'JoingGroupAction{groupName: $groupName}';
  }
}

class ChangeGroupOwnerAction {
  final String groupName;
  final String newOwnerName;

  ChangeGroupOwnerAction(this.groupName, this.newOwnerName);

  @override
  String toString() {
    return 'ChangeGroupOwnerAction{groupName: $groupName, '
        'newOwnerName: $newOwnerName}';
  }
}

class LeaveGroupAction {
  final String groupName;

  LeaveGroupAction(this.groupName);

  @override
  String toString() {
    return 'LeaveGroupAction{groupName: $groupName}';
  }
}

class DeleteGroupAction {
  final String groupName;

  DeleteGroupAction(this.groupName);

  @override
  String toString() {
    return 'DeleteGroupAction{groupName: $groupName}';
  }
}
