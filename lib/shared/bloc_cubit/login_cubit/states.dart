import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}
class InitialLoginStates extends LoginStates{}

class LoadingLoginStates extends LoginStates {}
class SuccessLoginStates extends LoginStates {
  final LoginModel loginModel;
  SuccessLoginStates(this.loginModel);
}
class ErorrLoginStates extends LoginStates {
  final String erorr;

  ErorrLoginStates(this.erorr);

}

class ChangeShowPasswordStates extends LoginStates {}