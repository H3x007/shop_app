import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme() => ThemeData(
    primarySwatch: Colors.deepOrange,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor, unselectedItemColor: Colors.grey));

ThemeData darkTheme() => ThemeData(
    scaffoldBackgroundColor: Color(0xFF121212),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      //backgroundColor: Color(0xFF121212),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    hintColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor, unselectedItemColor: Colors.grey));
