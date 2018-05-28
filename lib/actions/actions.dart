import 'dart:async';

import 'package:selfbet/models/models.dart';
import 'package:flutter/material.dart';

class InitAppAction {
  @override
  String toString() {
    return 'InitApp{}';
  }
}

class ConnectToDataSourceAction {
  @override
  String toString() {
    return 'ConnectToDataSource{}';
  }
}

class SetUserStreamAction{
  final StreamSubscription userStream;

  SetUserStreamAction(this.userStream);

  @override
  String toString() {
    return 'SetUserStream{userStream: $userStream}';
  }
}

class SetGroupStreamAction{
  final StreamSubscription groupStream;

  SetGroupStreamAction(this.groupStream);

  @override
  String toString() {
    return 'SetGroupStream{groupStream: $groupStream}';
  }
}

class SetBetStreamAction{
  final StreamSubscription betStream;

  SetBetStreamAction(this.betStream);

  @override
  String toString() {
    return 'SetBetStream{betStream: $betStream}';
  }
}

class LoadDashboardAction {
  final UserEntity userEntity;

  LoadDashboardAction(this.userEntity);

  @override
  String toString() {
    return 'LoadDashboard{userEntity: $userEntity}';
  }
}

class LoadGroupsAction {
  final List<Group> groups;

  LoadGroupsAction(this.groups);

  @override
  String toString() {
    return 'LoadGroups{groups: $groups}';
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
    return 'LoadBets{bets: $bets}';
  }
}

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTab{newTab: $newTab}';
  }
}

class CreditFaucetAction {
  @override
  String toString() {
    return 'CreditFaucet{}';
  }
}

class PlaceBetAction {
  final Bet bet;

  PlaceBetAction(this.bet);

  @override
  String toString() {
    return 'Placebet{Bet: $bet}';
  }
}

class DeleteBetAction {
  final Bet bet;

  DeleteBetAction(this.bet);

  @override
  String toString() {
    return 'DeleteBet{}';
  }
}

class RenewBetAction {
  final Bet bet;

  RenewBetAction(this.bet);

  @override
  String toString() {
    return 'RenewBet{}';
  }
}

class ExpireBetAction {  //Temp action for testing
  final Bet bet;

  ExpireBetAction(this.bet);

  @override
  String toString() {
    return 'ExpireBet{bet: $bet}';
  }
}

class CreateGroupAction {
  final Group group;
  final Function onComplete;
  final Function onFail;

  CreateGroupAction(this.group, this.onComplete, this.onFail);

  @override
  String toString() {
    return 'CreateGroup{group: $group}';
  }
}

class JoinGroupAction {
  final String groupName;
  final Function onComplete;
  final Function onFail;

  JoinGroupAction(this.groupName, this.onComplete, this.onFail);

  @override
  String toString() {
    return 'JoingGroup{}';
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
    return 'LeaveGroup{groupName: $groupName}';
  }
}

class DeleteGroupAction {
  final String groupName;

  DeleteGroupAction(this.groupName);

  @override
  String toString() {
    return 'DeleteGroup{groupName: $groupName}';
  }
}
