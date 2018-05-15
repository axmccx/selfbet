import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware() {

  return [
    TypedMiddleware<AppState, LogIn>(
      _firestoreEmailSignIn(),
    ),
    TypedMiddleware<AppState, CreateAccount>(
      _firestoreEmailCreateUser(),
    ),
    TypedMiddleware<AppState, LogOut>(
      _firestoreLogOut(),
    )
  ];
}

Middleware<AppState> _firestoreEmailSignIn() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is LogIn)
      try {
        final FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
          email: action.username,
          password: action.password,
        );
        store.dispatch(LogInSuccessful(user: user));
      } catch (error) {
        store.dispatch(LogInFail(error));
      }
    next(action);
  };
}

Middleware<AppState> _firestoreEmailCreateUser() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is CreateAccount) {
      try {
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: action.username,
              password: action.password,
          );
        store.dispatch(MoveToLogin());
        store.dispatch(LogIn(action.username, action.password));
      } catch (error) {
        print(error);
      }
    }
    next(action);
  };
}

Middleware<AppState> _firestoreLogOut() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (action is LogOut) {
      try {
        await _firebaseAuth.signOut();
        store.dispatch(LogOutSuccessful());
      } catch (error) {
        print(error);
      }
    }
    next(action);
  };
}