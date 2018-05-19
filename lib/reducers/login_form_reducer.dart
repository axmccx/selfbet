import 'package:selfbet/actions/auth_actions.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';

final loginFormReducer = combineReducers<FormType>([
  TypedReducer<FormType, MoveToLoginAction>(_moveToLogin),
  TypedReducer<FormType, MoveToRegisterAction>(_moveToRegister),
]);

FormType _moveToLogin(FormType formType, action) {
  return FormType.login;
}

FormType _moveToRegister(FormType formType, action) {
  return FormType.register;
}
