import 'dart:async';

import 'package:selfbet/models/models.dart';

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
  final StreamSubscription groupSteam;

  SetGroupStreamAction(this.groupSteam);

  @override
  String toString() {
    return 'SetGroupStream{groupStream: $groupSteam}';
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
  @override
  String toString() {
    return 'Placebet{}';
  }
}

class DeleteBetAction {
  @override
  String toString() {
    return 'DeleteBet{}';
  }
}

class RenewBetAction {
  @override
  String toString() {
    return 'RenewBet{}';
  }
}

class JoinGroupAction {
  final String groupName;

  JoinGroupAction(this.groupName);

  @override
  String toString() {
    return 'JoingGroup{}';
  }
}

class CreateGroupAction {
  final Group group;

  CreateGroupAction(this.group);

  @override
  String toString() {
    return 'CreateGroup{group: $group}';
  }
}

class LeaveGroupAction {
  @override
  String toString() {
    return 'LeaveGroup{}';
  }
}

class PlaceHolderAction{
  @override
  String toString() {
    return 'PlaceHolder{}';
  }
}
