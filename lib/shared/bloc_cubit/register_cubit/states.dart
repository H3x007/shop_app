import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates {}
class InitialRegisterState extends RegisterStates{}

class LoadingRegisterStates extends RegisterStates {}
class SuccessRegisterStates extends RegisterStates {
  final LoginModel loginModel;
  SuccessRegisterStates(this.loginModel);
}
class ErorrRegisterStates extends RegisterStates {}

class ChangeShowPasswordRegisterStates extends RegisterStates {}