import 'package:meta/meta.dart';
import 'package:selfbet/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class AppState {
  final bool isLoading;
  final int balance;
  final int atStake;
  final List<Bet> bets;
  final List<Group> groups;
  final AppTab activeTab;
  final FormType formType;
  final FirebaseUser currentUser;

  AppState({
    this.isLoading = false,
    this.balance = 0,
    this.atStake = 0,
    this.bets = const [],
    this.groups = const [],
    this.activeTab = AppTab.dashboard,
    this.formType = FormType.login,
    this.currentUser,
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    int balance,
    int atStake,
    List<Bet> bets,
    final List<Group> groups,
    AppTab activeTab,
    FormType formType,
    FirebaseUser currentUser
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      balance: balance ?? this.balance,
      atStake: atStake ?? this.atStake,
      bets: bets ?? this.bets,
      groups: groups ?? this.groups,
      activeTab: activeTab ?? this.activeTab,
      formType: formType ?? this.formType,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      balance.hashCode ^
      atStake.hashCode ^
      bets.hashCode ^
      groups.hashCode ^
      activeTab.hashCode ^
      formType.hashCode ^
      currentUser.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              isLoading == other.isLoading &&
              balance == other.balance &&
              atStake == other.atStake &&
              bets == other.bets &&
              groups == other.groups &&
              activeTab == other.activeTab &&
              formType == other.formType &&
              currentUser == other.currentUser;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, balance: $balance, '
        + 'atStake: $atStake, bets: $bets, groups: $groups, '
           + 'activeTab: $activeTab, Form Type: $formType, '
           + 'currentUser: $currentUser}';
  }
}