import 'package:selfbet/actions/auth_actions.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';

final loginFormReducer = combineReducers<FormType>([
  new TypedReducer<FormType, MoveToLogin>(_moveToLogin),
  new TypedReducer<FormType, MoveToRegister>(_moveToRegister),
]);

FormType _moveToLogin(FormType formType, action) {
  return FormType.login;
}

FormType _moveToRegister(FormType formType, action) {
  return FormType.register;
}
