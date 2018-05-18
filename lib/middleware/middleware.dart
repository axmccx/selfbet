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
    )
  ];
}

Middleware<AppState> _initApp(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    if (action is InitAppAction) {
      try {
        final FirebaseUser user = await repo.getCurrentUser();
        if (user != null) {
          store.dispatch(LogInSuccessfulAction(user: user));
          store.dispatch(ConnectToDataSourceAction());
        }
      } catch (e) {
        print(e);
      }
    }
  };
}

Middleware<AppState> _firestoreEmailSignIn(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    if (action is LogInAction)
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
    if (action is CreateAccountAction) {
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
    }
  };
}

Middleware<AppState> _firestoreLogOut(FirebaseUserRepo repo) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    if (action is LogOutAction) {
      try {
        await repo.signOut();
        store.dispatch(LogOutSuccessfulAction());
      } catch (e) {
        print(e);
      }
    }
  };
}

Middleware<AppState> _firestoreConnect(
    FirebaseUserRepo userRepo,
    FirebaseGroupsRepo groupsRepo,
    FirebaseBetsRepo betsRepo,
    ) {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    if (action is ConnectToDataSourceAction) {
      try {
        FirebaseUser user = store.state.currentUser;
        userRepo.userStream(user.uid).listen((userEntity) {
          store.dispatch(LoadDashboard(userEntity));
        });
      } catch (e) {
        print(e);
      }
    }
  };
}