import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/containers/display_group.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/repositories/repos.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware(
  FirebaseUserRepo userRepo,
  FirebaseGroupsRepo groupsRepo,
  FirebaseBetsRepo betsRepo,
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
      _firestoreLoadGroupMembers(userRepo),
    ),
  ];
}

Middleware<AppState> _initApp(FirebaseUserRepo repo) {
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

Middleware<AppState> _firestoreEmailSignIn(FirebaseUserRepo repo) {
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
      store.dispatch(LogInFailAction(e));
    }
  };
}

Middleware<AppState> _firestoreEmailCreateUser(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      repo.createUserEmailPass(
        action.username,
        action.password,
        action.name,
      );
      store.dispatch(MoveToLoginAction());
      store.dispatch(LogInAction(action.username, action.password));
    } catch (e) {
      print(e);
    }
  };
}

Middleware<AppState> _firestoreLogOut(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      store.state.userStream.cancel();
      await repo.signOut();
      store.dispatch(LogOutSuccessfulAction());
    } catch (e) {
      print(e);
    }
  };
}

Middleware<AppState> _firestoreConnect(FirebaseUserRepo userRepo,
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
    } catch (e) {
      print(e);
    }
  };
}

Middleware<AppState> _firestoreCreditFaucet(FirebaseUserRepo repo) {
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
      store.dispatch(LoadGroupMembersAction(action.context, action.group, members));
    } catch (e) {
      print(e);
    }
  };
}

void Function(
    Store<AppState> store,
    LoadGroupMembersAction action,
    NextDispatcher next,
    ) _firestoreLoadGroupMembers(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      Navigator.of(action.context).push(MaterialPageRoute(
        builder: (context) {
          return DisplayGroup(action.group);
        },
      ));

    } catch (e) {
      print(e);
    }
  };
}