import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _performLogin();
    }
  }

  void _performLogin() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      debugPrint('Signed in: ${user.uid}');
    } catch (e) {
      final snackbar = new SnackBar(
        content: new Text('Incorrect username or password'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Form(
          key: formKey,
          child: new ListView(
            children: <Widget>[
              new Image.asset(
                'images/loginLogo.png',
                width: 75.0,
                height: 75.0,
              ),
              new Padding(padding: new EdgeInsets.all(15.0)),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Email',
                ),
                validator: (val) =>
                    !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (val) => _email = val,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (s) {
                  FocusScope.of(context).requestFocus(_focusNode);
                },
              ),
              new Padding(padding: new EdgeInsets.all(8.0)),
              new TextFormField(
                focusNode: _focusNode,
                decoration: new InputDecoration(
                  labelText: 'Password',
                ),
                validator: (val) =>
                    val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
                onFieldSubmitted: (s) { _submit(); },
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new RaisedButton(
                onPressed: _submit,
                child: new Text("Login"),
              ),
              new Padding(padding: new EdgeInsets.all(20.0)),
              new Center(
                child: new InkWell(
                  onTap: () => debugPrint('Create new account!'),
                  child: new Text(
                    'No account yet? Create one',
                    style: new TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

