import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/repositories/repos.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware(
    FirebaseUserRepo userRepo,
    FirebaseGroupsRepo groupsRepo,
    FirebaseBetsRepo betsRepo,
    NativeCodeRepo nativeCodeRepo,
  ) {
  return [
    TypedMiddleware<AppState, InitAppAction>(
      _initApp(userRepo),
    ),
    TypedMiddleware<AppState, LogInAction>(
      _firestoreEmailSignIn(userRepo),
    ),
    TypedMiddleware<AppState, CreateAccountAction>(
      _firestoreEmailCreateUser(userRepo),
    ),
    TypedMiddleware<AppState, LogOutAction>(
      _firestoreLogOut(userRepo),
    ),
    TypedMiddleware<AppState, ConnectToDataSourceAction>(
      _firestoreConnect(userRepo, groupsRepo, betsRepo),
    ),
    TypedMiddleware<AppState, CreditFaucetAction>(
      _firestoreCreditFaucet(userRepo),
    ),
    TypedMiddleware<AppState, CreateGroupAction>(
      _firestoreCreateGroup(groupsRepo),
    ),
    TypedMiddleware<AppState, JoinGroupAction>(
      _firestoreJoinGroup(groupsRepo),
    ),
    TypedMiddleware<AppState, GetGroupMembersAction>(
      _firestoreGetGroupMembers(userRepo),
    ),
    TypedMiddleware<AppState, LoadGroupMembersAction>(
      _firestoreLoadGroupMembers(),
    ),
    TypedMiddleware<AppState, ChangeGroupOwnerAction>(
      _firestoreUpdateGroupOwner(groupsRepo),
    ),
    TypedMiddleware<AppState, LeaveGroupAction>(
      _firestoreLeaveGroup(groupsRepo),
    ),
    TypedMiddleware<AppState, DeleteGroupAction>(
      _firestoreDeleteGroup(groupsRepo),
    ),
    TypedMiddleware<AppState, PlaceBetAction>(
      _firestorePlaceBet(userRepo, groupsRepo, betsRepo, nativeCodeRepo),
    ),
    TypedMiddleware<AppState, ExpireBetAction>(  // temporary for testing
      _firestoreExpireBet(betsRepo),
    ),
    TypedMiddleware<AppState, DeleteBetAction>(
      _firestoreDeleteBet(betsRepo),
    ),
    TypedMiddleware<AppState, RenewBetAction>(
      _firestoreRenewBet(userRepo, groupsRepo, betsRepo),
    ),
    TypedMiddleware<AppState, SnoozeAlarmBetAction>(
      _firestoreSnoozeAlarmBet(betsRepo),
    ),
    TypedMiddleware<AppState, SetWinBetAction>(  // temporary for testing
      _firestoreSetWinBet(betsRepo),
    ),
    TypedMiddleware<AppState, GetTransactionMembersAction>(
      _firestoreGetTransactionMembers(userRepo),
    ),
    TypedMiddleware<AppState, LoadTransactionMembersAction>(
      _firestoreLoadTransactionMembers(),
    ),
  ];
}

void Function(
    Store<AppState> store,
    InitAppAction action,
    NextDispatcher next,
    ) _initApp(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      final FirebaseUser user = await repo.getCurrentUser();
      if (user != null) {
        store.dispatch(LogInSuccessfulAction(user: user));
        store.dispatch(ConnectToDataSourceAction());
      }
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    LogInAction action,
    NextDispatcher next,
    ) _firestoreEmailSignIn(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      final FirebaseUser user = await repo.login(
        action.username,
        action.password,
      );
      store.dispatch(LogInSuccessfulAction(user: user));
      store.dispatch(ConnectToDataSourceAction());
    } catch (e) {
      action.onFail();
      store.dispatch(LogInFailAction(e));
    }
  };
}

void Function(
    Store<AppState> store,
    CreateAccountAction action,
    NextDispatcher next,
    ) _firestoreEmailCreateUser(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      await repo.createUserEmailPass(
        action.username,
        action.password,
        action.name,
      );
      store.dispatch(MoveToLoginAction());
      store.dispatch(LogInAction(action.username, action.password, action.onFail));
    } catch (e) {
      action.onFail();
      store.dispatch(LogInFailAction(e));
    }
  };
}

void Function(
    Store<AppState> store,
    LogOutAction action,
    NextDispatcher next,
    ) _firestoreLogOut(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      store.state.userStream.cancel();
      store.state.groupStream.cancel();
      store.state.betStream.cancel();
      store.state.betTransactStream.cancel();
      await repo.signOut();
      store.dispatch(LogOutSuccessfulAction());
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    ConnectToDataSourceAction action,
    NextDispatcher next,
    ) _firestoreConnect(FirebaseUserRepo userRepo,
    FirebaseGroupsRepo groupsRepo, FirebaseBetsRepo betsRepo,) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      FirebaseUser user = store.state.currentUser;
      StreamSubscription userStream = userRepo.userStream(user.uid)
          .listen((userEntity) {
            store.dispatch(LoadDashboardAction(userEntity));
      });
      store.dispatch(SetUserStreamAction(userStream));
      StreamSubscription groupStream = groupsRepo.groupStream(user.uid)
        .listen((groups) {
          store.dispatch(LoadGroupsAction(groups));
      });
      store.dispatch(SetGroupStreamAction(groupStream));
      StreamSubscription betSteam = betsRepo.betStream(user.uid)
        .listen((bets) {
          store.dispatch(LoadBetsAction(bets));
      });
      store.dispatch(SetBetStreamAction(betSteam));
      StreamSubscription betTransactStream = userRepo.betTransactStream(user.uid)
        .listen((betTransacts) {
          store.dispatch(LoadBetTransactAction(betTransacts));
      });
      store.dispatch(SetBetTransactStreamAction(betTransactStream));
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    CreditFaucetAction action,
    NextDispatcher next,
    ) _firestoreCreditFaucet(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      FirebaseUser user = store.state.currentUser;
      repo.addCredits(user.uid);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
  Store<AppState> store,
  CreateGroupAction action,
  NextDispatcher next,
) _firestoreCreateGroup(FirebaseGroupsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.createGroup(action.group).then((msg) {
        if (msg != null) {
          action.onFail(msg);
        } else {
          action.onComplete();
          store.dispatch(LoadGroupsAction);
        }
      });
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    JoinGroupAction action,
    NextDispatcher next,
    ) _firestoreJoinGroup(FirebaseGroupsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      FirebaseUser user = store.state.currentUser;
      repo.joinGroup(action.groupName, user.uid).then((msg) {
        if (msg != null) {
          action.onFail(msg);
        } else {
          action.onComplete();
          store.dispatch(LoadGroupsAction);
        }
      });
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    GetGroupMembersAction action,
    NextDispatcher next,
    ) _firestoreGetGroupMembers(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      List<UserEntity> members = await repo.getGroupMembers(action.groupMemberUids);
      store.dispatch(LoadGroupMembersAction(
        groupMembers: members,
        callBack: action.callBack,
      ));
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    LoadGroupMembersAction action,
    NextDispatcher next,
    ) _firestoreLoadGroupMembers() {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      action.callBack();
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    ChangeGroupOwnerAction action,
    NextDispatcher next,
    ) _firestoreUpdateGroupOwner(FirebaseGroupsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.updateGroupOwner(action.groupName, action.newOwnerName);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    LeaveGroupAction action,
    NextDispatcher next,
    ) _firestoreLeaveGroup(FirebaseGroupsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      FirebaseUser user = store.state.currentUser;
      repo.leaveGroup(action.groupName, user.uid);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    DeleteGroupAction action,
    NextDispatcher next,
    ) _firestoreDeleteGroup(FirebaseGroupsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.deleteGroup(action.groupName);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    PlaceBetAction action,
    NextDispatcher next,
    ) _firestorePlaceBet(
    FirebaseUserRepo userRepo,
    FirebaseGroupsRepo groupsRepo,
    FirebaseBetsRepo betsRepo,
    NativeCodeRepo nativeCodeRepo,
    ) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      userRepo.updateBalanceAtStake(action.bet.uid, action.bet.amount);
      groupsRepo.updateGroupAtStake(
          action.bet.groupName,
          action.bet.uid,
          action.bet.amount,
      );
      betsRepo.placeBet(action.bet);
      if (action.bet.type == BetType.alarmClock) {
        //nativeCodeRepo.setAlarm(action.bet);
      }
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    ExpireBetAction action,
    NextDispatcher next,
    ) _firestoreExpireBet(FirebaseBetsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.expireBet(action.bet);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    DeleteBetAction action,
    NextDispatcher next,
    ) _firestoreDeleteBet(FirebaseBetsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.deleteBet(action.bet);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    RenewBetAction action,
    NextDispatcher next,
    ) _firestoreRenewBet(
    FirebaseUserRepo userRepo,
    FirebaseGroupsRepo groupsRepo,
    FirebaseBetsRepo betsRepo
    ) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      userRepo.updateBalanceAtStake(action.bet.uid, action.bet.amount);
      groupsRepo.updateGroupAtStake(
        action.bet.groupName,
        action.bet.uid,
        action.bet.amount,
      );
      betsRepo.renewBet(action.bet);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    SnoozeAlarmBetAction action,
    NextDispatcher next,
    ) _firestoreSnoozeAlarmBet(FirebaseBetsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.snoozeAlarmBet(action.bet);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    SetWinBetAction action,
    NextDispatcher next,
    ) _firestoreSetWinBet(FirebaseBetsRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.setWinBet(action.bet);
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    GetTransactionMembersAction action,
    NextDispatcher next,
    ) _firestoreGetTransactionMembers(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      List<UserEntity> members = await repo.getTransactionMembers(action.transaction);
      store.dispatch(LoadTransactionMembersAction(
        transactMembers: members,
        callBack: action.callBack,
      ));
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    LoadTransactionMembersAction action,
    NextDispatcher next,
    ) _firestoreLoadTransactionMembers() {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      action.callBack();
    } catch (e) {
      print(e);
    }
  };
}