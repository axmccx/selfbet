import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/presentation/loading_indicator.dart';

class LoginNewAccScreen extends StatelessWidget {
  final Function(String email, String password) onSubmit;
  final Function onSwitchForm;
  final bool isLoading;
  final bool newAccount;

  LoginNewAccScreen({
    @required this.onSubmit,
    @required this.onSwitchForm,
    @required this.isLoading,
    @required this.newAccount,
  });

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  FocusNode _focusEmail;
  FocusNode _focusPassword;

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      onSubmit(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: new EdgeInsets.all(30.0),
            child: new Form(
              key: formKey,
              child: new ListView(
                children: buildInputs() + buildSubmitButtons(),
              ),
            ),
          ),
          new Align(
            child: isLoading ? LoadingIndicator() : Container(),
            alignment: FractionalOffset.center,
          ),
        ],
      ),
    );
  }

  List<Widget> buildInputs() {
    if (newAccount) {
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
            labelText: 'Email',
          ),
          validator: (val) =>
          !val.contains('@') ? 'Not a valid email.' : null,
          onSaved: (val) => _email = val,
          keyboardType: TextInputType.emailAddress,
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
    }
  }

  List<Widget> buildSubmitButtons() {
    if (newAccount) {
      return [
        new RaisedButton(
          onPressed: _submit,
          child: new Text("Create Account"),
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),
        new Center(
          child: new InkWell(
            onTap: onSwitchForm,
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
    } else {
      return [
        new RaisedButton(
          onPressed: _submit,
          child: new Text("Login"),
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),
        new Center(
          child: new InkWell(
            onTap: onSwitchForm,
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
    }
  }
}
