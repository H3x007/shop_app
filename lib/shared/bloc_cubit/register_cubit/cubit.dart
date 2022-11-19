import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/bloc_cubit/register_cubit/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/helper/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(LoadingRegisterStates());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      //print(value.data);
      loginModel = LoginModel.fromJason(value.data);
      emit(SuccessRegisterStates(loginModel!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ErorrRegisterStates());
    });
  }

  bool showPassword = true;
  void changeShowPassword() {
    showPassword = !showPassword;
    emit(ChangeShowPasswordRegisterStates());
  }

}
