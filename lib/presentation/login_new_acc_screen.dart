import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/presentation/loading_indicator.dart';

typedef OnLoginCallBack = Function(BuildContext,  GlobalKey<ScaffoldState>, String, String, String);

//I must improve this class, so messy. Look at the group form.
class LoginNewAccScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  final OnLoginCallBack onSubmit;
  final Function onSwitchForm;
  final bool isLoading;
  final bool newAccount;

  LoginNewAccScreen({
    @required this.onSubmit,
    @required this.onSwitchForm,
    @required this.isLoading,
    @required this.newAccount,
  });

  String _name;
  String _email;
  String _password;

  void _submit(BuildContext context) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      onSubmit(context, _scaffoldKey, _email, _password, _name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: buildInputs(context) + buildSubmitButtons(context),
              ),
            ),
          ),
          Align(
            child: isLoading
                ? LoadingIndicator("Authenticating")
                : Container(),
            alignment: FractionalOffset.center,
          ),
        ],
      ),
    );
  }

  List<Widget> buildInputs(BuildContext context) {
    if (newAccount) {
      return [
        Image.asset(
          'images/loginLogo.png',
          width: 75.0,
          height: 75.0,
        ),
        Padding(padding: EdgeInsets.all(15.0)),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
          ),
          validator: (val) =>
          val.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (val) => _name = val,
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        TextFormField(
          //focusNode: _focusEmail,
          decoration: InputDecoration(
            labelText: 'Email',
          ),
          validator: (val) =>
          !val.contains('@') ? 'Not a valid email.' : null,
          onSaved: (val) => _email = val,
          keyboardType: TextInputType.emailAddress,
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        TextFormField(
          //focusNode: _focusPassword,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
          validator: (val) =>
          val.length < 6 ? 'Password too short.' : null,
          onSaved: (val) => _password = val,
          obscureText: true,
          onFieldSubmitted: (s) { _submit(context); },
        ),
        Padding(padding: EdgeInsets.all(20.0)),
      ];
    } else {
      return [
        Image.asset(
          'images/loginLogo.png',
          width: 75.0,
          height: 75.0,
        ),
        Padding(padding: EdgeInsets.all(15.0)),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
          ),
          validator: (val) =>
          !val.contains('@') ? 'Not a valid email.' : null,
          onSaved: (val) => _email = val,
          keyboardType: TextInputType.emailAddress,
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        TextFormField(
          //focusNode: _focusPassword,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
          validator: (val) =>
          val.length < 6 ? 'Password too short.' : null,
          onSaved: (val) => _password = val,
          obscureText: true,
          onFieldSubmitted: (s) { _submit(context); },
        ),
        Padding(padding: EdgeInsets.all(20.0)),
      ];
    }
  }

  List<Widget> buildSubmitButtons(BuildContext context) {
    if (newAccount) {
      return [
        RaisedButton(
          onPressed: () { _submit(context); },
          child: Text("Create Account"),
        ),
        Padding(padding: EdgeInsets.all(20.0)),
        Center(
          child: InkWell(
            onTap: () { onSwitchForm(_formKey); },
            child: Text(
              'Already a member? Login',
              style: TextStyle(
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
        RaisedButton(
          onPressed: () { _submit(context); },
          child: Text("Login"),
        ),
        Padding(padding: EdgeInsets.all(20.0)),
        Center(
          child: InkWell(
            onTap: () { onSwitchForm(_formKey); },
            child: Text(
              'No account yet? Create one',
              style: TextStyle(
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
