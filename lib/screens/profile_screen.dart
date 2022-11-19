import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/widgets/my_button.dart';
import 'package:shop_app/widgets/my_form_field.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  /// Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).loginModel;
        nameController.text = cubit!.data!.name!;
        emailController.text = cubit.data!.email!;
        phoneController.text = cubit.data!.phone!;
        return ConditionalBuilder(
          condition: cubit != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://student.valuxapps.com/storage/assets/defaults/user.jpg',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      label: 'User Name',
                      suffix: Icons.person,
                    ),
                    MyFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      suffix: Icons.email,
                    ),
                    MyFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      suffix: Icons.phone,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MyButton(
                      text: 'Update Data',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                          showToast(
                              msg: cubit.message ?? '',
                              state: ToastStates.SUCCESS);
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MyButton(
                      text: 'Sign out',
                      onPressed: () {
                        signOut(context);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Change Theme Mode', style: TextStyle(fontSize: 18),),
                        Spacer(),
                        Switch(
                          value: ShopCubit.get(context).isDark,
                          onChanged: (value) {
                            ShopCubit.get(context).changeMode();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
