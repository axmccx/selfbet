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
  final List<dynamic> groupNames;
  final List<Group> groups;
  final AppTab activeTab;
  final FormType formType;
  final FirebaseUser currentUser;

  AppState({
    this.isLoading = false,
    this.name = "",
    this.balance = 0,
    this.atStake = 0,
    this.bets = const [],
    this.groupNames = const[],
    this.groups = const [],
    this.activeTab = AppTab.dashboard,
    this.formType = FormType.login,
    this.currentUser,
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    String name,
    int balance,
    int atStake,
    List<Bet> bets,
    List<String> groupNames,
    List<Group> groups,
    AppTab activeTab,
    FormType formType,
    FirebaseUser currentUser
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      atStake: atStake ?? this.atStake,
      bets: bets ?? this.bets,
      groupNames: groupNames ?? this.groupNames,
      groups: groups ?? this.groups,
      activeTab: activeTab ?? this.activeTab,
      formType: formType ?? this.formType,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      name.hashCode ^
      balance.hashCode ^
      atStake.hashCode ^
      bets.hashCode ^
      groupNames.hashCode ^
      groups.hashCode ^
      activeTab.hashCode ^
      formType.hashCode ^
      currentUser.hashCode;

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
              groupNames == other.groupNames &&
              groups == other.groups &&
              activeTab == other.activeTab &&
              formType == other.formType &&
              currentUser == other.currentUser;

  @override
  String toString() {
    return 'AppState{name: $name, isLoading: $isLoading, balance: $balance, '
        + 'atStake: $atStake, bets: $bets, group names: $groupNames '
           + 'groups: $groups, activeTab: $activeTab, Form Type: $formType, '
           + 'currentUser: $currentUser}';
  }
}