import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/search_screen.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                navigateTo(context, SearchScreen());
              },
              icon: Icon(Icons.search),
            ),
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: subHeadingStyle.copyWith(color: defaultColor),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.changeMode();
                },
                icon: cubit.isDark
                    ? Icon(EvaIcons.moonOutline)
                    : Icon(Icons.wb_sunny),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.apps), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
            ],
          ),
        );
      },
    );
  }
}
