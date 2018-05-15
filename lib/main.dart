import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/reducers/root_reducer.dart';
import 'package:selfbet/presentation/home_screen.dart';
import 'package:selfbet/containers/containers.dart';


void main() {
  runApp(new SelfbetApp());
}

class SelfbetApp extends StatelessWidget {
  final Store<AppState> store;

  SelfbetApp() : store = Store<AppState> (
    rootReducer,
    initialState: AppState.loading(),
    middleware: [LoggingMiddleware.printer()],

  ){
    store.dispatch(InitAppAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "Selfbet",
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: getFirstPage(),
      ),
    );
  }

  Widget getFirstPage() {
    if (store.state.currentUser == null) {
        return ShowLogin();
    }
    return HomeScreen();
  }
}