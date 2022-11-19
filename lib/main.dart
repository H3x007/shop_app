import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/helper/cache_helper.dart';
import 'package:shop_app/shared/network/helper/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  token = CacheHelper.getData(key: 'token');
  Widget widget;

  /// This is For Shared Prefrencses to Save Screen
  if (onBoarding != null) {
    if (token != null)
      widget = HomeScreen();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget, isDark));
}

class MyApp extends StatelessWidget {
  MyApp(
    this.isDark, {
    super.key,
    required this.startWidget,
  });
  final Widget startWidget;
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData()
        ..getCartItem()
        ..changeMode(
          fromShared: isDark
        ),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return MaterialApp(
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
