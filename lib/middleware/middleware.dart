import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware() {

  return [
    TypedMiddleware<AppState, InitAppAction>(
      _initApp(),
    ),
    TypedMiddleware<AppState, LogInAction>(
      _firestoreEmailSignIn(),
    ),
    TypedMiddleware<AppState, CreateAccountAction>(
      _firestoreEmailCreateUser(),
    ),
    TypedMiddleware<AppState, LogOutAction>(
      _firestoreLogOut(),
    )
  ];
}

Middleware<AppState> _initApp() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is InitAppAction) {
      try {
        final FirebaseUser user = await _firebaseAuth.currentUser();
        if (user != null) {
          store.dispatch(LogInSuccessfulAction(user: user));
        }
      } catch (e) {
        print(e);
      }
    }
    next(action);
  };
}

Middleware<AppState> _firestoreEmailSignIn() {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is LogInAction)
      try {
        final FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
          email: action.username,
          password: action.password,
        );
        store.dispatch(LogInSuccessfulAction(user: user));
      } catch (e) {
        store.dispatch(LogInFailAction(e));
      }
  };
}

Middleware<AppState> _firestoreEmailCreateUser() {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is CreateAccountAction) {
      try {
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: action.username,
              password: action.password,
          );
        store.dispatch(MoveToLoginAction());
        store.dispatch(LogInAction(action.username, action.password));
      } catch (e) {
        print(e);
      }
    }
  };
}

Middleware<AppState> _firestoreLogOut() {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is LogOutAction) {
      try {
        await _firebaseAuth.signOut();
        store.dispatch(LogOutSuccessfulAction());
      } catch (e) {
        print(e);
      }
    }
  };
}