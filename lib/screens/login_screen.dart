import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/register_screen.dart';
import 'package:shop_app/shared/bloc_cubit/login_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/login_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/helper/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/my_button.dart';
import 'package:shop_app/widgets/my_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SuccessLoginStates) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {

                token = state.loginModel.data!.token;
                navigateToAndClose(context, HomeScreen());
                Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  backgroundColor: Colors.green,
                  toastLength: Toast.LENGTH_LONG,
                );
              });
            } else {
              showToast(
                  msg: state.loginModel.message!, state: ToastStates.ERORR);
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Sign In',
                style: TextStyle(color: miniTitleColor, fontSize: 30),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 30),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 170,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Welcome Back',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sing In with Your Email And Password',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        MyFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          hint: 'Enter Your Email',
                          label: 'Email',
                          suffix: Icons.email,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter Your Email';
                            }
                          },
                        ),
                        MyFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          showPassword: cubit.showPassword,
                          hint: 'Enter Your Password',
                          label: 'Password',
                          suffix: cubit.showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          suffixPressed: () {
                            cubit.changeShowPassword();
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Enter Your Password';
                            }
                          },
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            'Forget Password',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoadingLoginStates,
                          builder: (context) => MyButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: defaultColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
