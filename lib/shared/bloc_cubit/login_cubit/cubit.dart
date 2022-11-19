import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/bloc_cubit/login_cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/helper/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoadingLoginStates());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJason(value.data);
      //print(loginModel!.data!.token);
      emit(SuccessLoginStates(loginModel!));
    }).catchError((erorr) {
      emit(ErorrLoginStates(erorr.toString()));
    });
  }

  bool showPassword = true;
  void changeShowPassword() {
    showPassword = !showPassword;
    emit(ChangeShowPasswordStates());
  }
}
