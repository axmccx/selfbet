import 'package:flutter/material.dart';
import 'package:selfbet/auth.dart';


class HomePage extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  HomePage({this.auth, this.onSignedOut});

  void _signedOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Selfbet'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.exit_to_app),
              onPressed: _signedOut,
          ),
        ],
      ),
      body: new Container(
        child: new Center(
          child: new Text(
            'Welcome!',
            style: new TextStyle(
              fontSize: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
