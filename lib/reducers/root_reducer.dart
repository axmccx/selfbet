import 'package:selfbet/models/models.dart';
import 'package:selfbet/reducers/reducers.dart';

AppState rootReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    name: nameReducer(state.name, action),
    balance: balanceReducer(state.balance, action),
    atStake: atStakeReducer(state.atStake, action),
    bets: betsReducer(state.bets, action),
    groups: groupsReducer(state.groups, action),
    groupMembers: groupMembersReducer(state.groupMembers, action),
    betTransacts: betTransactsReducer(state.betTransacts, action),
    activeTab: tabsReducer(state.activeTab, action),
    formType: loginFormReducer(state.formType, action),
    currentUser: authReducer(state.currentUser, action),
    userStream: userStreamReducer(state.userStream, action),
    betStream: betStreamReducer(state.betStream, action),
    betTransactStream: betTransactStreamReducer(
        state.betTransactStream, action),
  );
}