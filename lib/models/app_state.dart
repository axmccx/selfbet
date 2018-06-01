import 'dart:async';

import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class AppState {
  final bool isLoading;
  final String name;
  final int balance;
  final int atStake;
  final List<Bet> bets;
  final List<Group> groups;
  final List<UserEntity> groupMembers;
  final List<BetTransact> betTransacts;
  final AppTab activeTab;
  final FormType formType;
  final FirebaseUser currentUser;
  final StreamSubscription userStream;
  final StreamSubscription groupStream;
  final StreamSubscription betStream;
  final StreamSubscription betTransactStream;

  AppState({
    this.isLoading = false,
    this.name = "",
    this.balance = 0,
    this.atStake = 0,
    this.bets = const [],
    this.groups = const [],
    this.groupMembers = const [],
    this.betTransacts = const [],
    this.activeTab = AppTab.dashboard,
    this.formType = FormType.login,
    this.currentUser,
    this.userStream,
    this.groupStream,
    this.betStream,
    this.betTransactStream,
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    String name,
    int balance,
    int atStake,
    List<Bet> bets,
    List<Group> groups,
    List<UserEntity> groupMembers,
    List<BetTransact> betTransacts,
    AppTab activeTab,
    FormType formType,
    FirebaseUser currentUser,
    StreamSubscription userStream,
    StreamSubscription groupStream,
    StreamSubscription betStream,
    StreamSubscription betTransactStream,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      atStake: atStake ?? this.atStake,
      bets: bets ?? this.bets,
      groups: groups ?? this.groups,
      groupMembers: groupMembers ?? this.groupMembers,
      betTransacts: betTransacts ?? this.betTransacts,
      activeTab: activeTab ?? this.activeTab,
      formType: formType ?? this.formType,
      currentUser: currentUser ?? this.currentUser,
      userStream: userStream ?? this.userStream,
      groupStream: groupStream ?? this.groupStream,
      betStream:  betStream ?? this.betStream,
      betTransactStream: betTransactStream ?? this.betTransactStream,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      name.hashCode ^
      balance.hashCode ^
      atStake.hashCode ^
      bets.hashCode ^
      groups.hashCode ^
      groupMembers.hashCode ^
      betTransacts.hashCode ^
      activeTab.hashCode ^
      formType.hashCode ^
      currentUser.hashCode ^
      userStream.hashCode ^
      groupStream.hashCode ^
      betStream.hashCode ^
      betTransactStream.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              isLoading == other.isLoading &&
              balance == other.balance &&
              atStake == other.atStake &&
              bets == other.bets &&
              groups == other.groups &&
              groupMembers == other.groupMembers &&
              betTransacts == other.betTransacts &&
              activeTab == other.activeTab &&
              formType == other.formType &&
              currentUser == other.currentUser &&
              userStream == other.userStream &&
              groupStream == other.groupStream &&
              betStream == other.betStream &&
              betTransactStream == other.betTransactStream;

  @override
  String toString() {
    return 'AppState{'
        'name: $name, '
        'isLoading: $isLoading, '
        'balance: $balance, '
        'atStake: $atStake, '
        'bets: $bets, '
        'groups: $groups, '
        'groupMembers: $groupMembers, '
        'betTransacts: $betTransacts, '
        'activeTab: $activeTab, '
        'Form Type: $formType, '
        'currentUser: $currentUser, '
        'userStream: $userStream, '
        'groupStream: $groupStream, '
        'betStream: $betStream, '
        'betTransactStream: $betTransactStream'
        '}';
  }
}