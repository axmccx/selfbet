import 'package:flutter/material.dart';
import 'package:selfbet/auth.dart';

class LoginPage extends StatefulWidget {
  final Auth auth;
  final VoidCallback onSignedIn;
  LoginPage({this.auth, this.onSignedIn});

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  FormType _formType = FormType.login;
  FocusNode _focusEmail;
  FocusNode _focusPassword;

  @override
  void initState() {
    super.initState();
    _focusEmail = new FocusNode();
    _focusPassword = new FocusNode();
  }

  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_formType == FormType.login) {
        _performLogin();
      } else {
        _createAccount();
      }
    }
  }

  void _performLogin() async {
    try {
      String userId = await widget.auth.signInEmailAndPass(_email, _password);
      debugPrint('Signed in: $userId');
      widget.onSignedIn();
    } catch (e) {
      final snackbar = new SnackBar(
        content: new Text('Incorrect username or password'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  void _createAccount() async {
    try {
      String userId = await widget.auth.createUserEmailandPass(_email, _password);
      debugPrint('Signed in: $userId');
      widget.onSignedIn();
    } catch (e) {
      final snackbar = new SnackBar(
        content: new Text('An Error Occured...'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
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
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {

    if (_formType == FormType.login) {
      return [
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
            FocusScope.of(context).requestFocus(_focusPassword);
          },
        ),
        new Padding(padding: new EdgeInsets.all(8.0)),
        new TextFormField(
          focusNode: _focusPassword,
          decoration: new InputDecoration(
            labelText: 'Password',
          ),
          validator: (val) =>
          val.length < 6 ? 'Password too short.' : null,
          onSaved: (val) => _password = val,
          //obscureText: true,
          onFieldSubmitted: (s) { _submit(); },
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),
      ];
    } else {
      return [
        new Image.asset(
          'images/loginLogo.png',
          width: 75.0,
          height: 75.0,
        ),
        new Padding(padding: new EdgeInsets.all(15.0)),
        new TextFormField(
          decoration: new InputDecoration(
            labelText: 'Name',
          ),
          validator: (val) =>
          val.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (val) => _name = val,
          onFieldSubmitted: (s) {
            FocusScope.of(context).requestFocus(_focusEmail);
          },
        ),
        new Padding(padding: new EdgeInsets.all(8.0)),
        new TextFormField(
          focusNode: _focusEmail,
          decoration: new InputDecoration(
            labelText: 'Email',
          ),
          validator: (val) =>
          !val.contains('@') ? 'Not a valid email.' : null,
          onSaved: (val) => _email = val,
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (s) {
            FocusScope.of(context).requestFocus(_focusPassword);
          },
        ),
        new Padding(padding: new EdgeInsets.all(8.0)),
        new TextFormField(
          focusNode: _focusPassword,
          decoration: new InputDecoration(
            labelText: 'Password',
          ),
          validator: (val) =>
            val.length < 6 ? 'Password too short.' : null,
          onSaved: (val) => _password = val,
          obscureText: true,
          onFieldSubmitted: (s) {
            _submit();
          },
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          onPressed: _submit,
          child: new Text("Login"),
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),
        new Center(
          child: new InkWell(
            onTap: moveToRegister,
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
      ];
    } else {
      return [
        new RaisedButton(
          onPressed: _submit,
          child: new Text("Create Account"),
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),
        new Center(
          child: new InkWell(
            onTap: moveToLogin,
            child: new Text(
              'Already a member? Login',
              style: new TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ];
    }
  }
}

