import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/bloc_cubit/login_cubit/states.dart';
import 'package:shop_app/shared/bloc_cubit/register_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/register_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/helper/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/widgets/my_button.dart';
import 'package:shop_app/widgets/my_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  /// Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SuccessRegisterStates) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token).then((value) {
                showToast(
                  msg: state.loginModel.message!,
                  state: ToastStates.SUCCESS,
                );
                token = state.loginModel.data!.token;
                navigateToAndClose(context, HomeScreen());
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Registration'),
                ),
            body: Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Welcome ...',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,),
                      ),
                      Text(
                        'Create an Account, Its free',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyFormField(
                        type: TextInputType.text,
                        controller: nameController,
                        hint: 'Enter Your Name',
                        label: 'User Name',
                        suffix: Icons.person,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter Your Name';
                          }
                        },
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
                        showPassword: RegisterCubit.get(context).showPassword,
                        hint: 'Enter Your Password',
                        label: 'Password',
                        suffix: RegisterCubit.get(context).showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        suffixPressed: () {
                          RegisterCubit.get(context).changeShowPassword();
                        },
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter Your Password';
                          }
                        },
                      ),
                      MyFormField(
                        type: TextInputType.phone,
                        controller: phoneController,
                        hint: 'Enter Your Phone',
                        label: 'Phone',
                        suffix: Icons.phone,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter Your Phone';
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoadingLoginStates,
                        builder: (context) => MyButton(
                          text: 'Sign Up',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'You have an account ? ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
