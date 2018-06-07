import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/actions/actions.dart';
import 'package:selfbet/reducers/root_reducer.dart';
import 'package:selfbet/presentation/root_screen.dart';
import 'package:selfbet/middleware/middleware.dart';
import 'package:selfbet/repositories/repos.dart';


void main() {
  runApp(SelfbetApp());
}

class SelfbetApp extends StatelessWidget {
  final Store<AppState> store;

  SelfbetApp() : store = Store<AppState>(
    rootReducer,
    initialState: AppState(),
    middleware: []
     ..addAll(createMiddleware(
       FirebaseUserRepo(FirebaseAuth.instance, Firestore.instance),
       FirebaseGroupsRepo(Firestore.instance),
       FirebaseBetsRepo(Firestore.instance),
       NativeCodeRepo(),
     ))
     ..add(LoggingMiddleware.printer()),

  ) {
    store.dispatch(InitAppAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "Selfbet",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootScreen(),
      ),
    );
  }
}