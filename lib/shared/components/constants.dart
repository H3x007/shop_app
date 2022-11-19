import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/helper/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

String? token = '';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateToAndClose(
        context,
        LoginScreen(),
      );
    }
  });
}

