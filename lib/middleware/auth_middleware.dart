import 'package:firebase_auth/firebase_auth.dart';
import 'package:selfbet/actions/auth_actions.dart';
import 'package:selfbet/models/models.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {

  return [
    TypedMiddleware<AppState, LogIn>(
      _createLogInMiddleware(),
    ),
    TypedMiddleware<AppState, LogOut>(
      _createLogOutMiddleware(),
    )
  ];

}

Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    FirebaseUser user;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is LogIn)
      try {
        //


        print('Logged in ' + user.displayName);

        store.dispatch(LogInSuccessful(user: user));
      } catch (error) {
        store.dispatch(LogInFail(error));
      }
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is LogOut) {
      try {
        await _auth.signOut();
        print('logging out...');
        store.dispatch(new LogOutSuccessful());
      } catch (error) {
        print(error);
      }
    }

    next(action);
  };
}