import 'package:flutter/material.dart';
import 'package:selfbet/ui/login_page.dart';
import 'package:selfbet/ui/home_page.dart';
import 'package:selfbet/auth.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});

  @override
  _RootPageState createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    if (widget.auth.currentUser() != null) {
      widget.auth.currentUser().then((userId) {
        setState(() {
          _authStatus = userId == null
              ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
      });
    }
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return new Container(
      child: Text('Auth Error'),
    );
  }
}
