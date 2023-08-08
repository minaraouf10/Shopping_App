import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sopping_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backwardsCompatibility: false,
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Jannah',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('333739')),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Jannah',
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: Colors.white),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  ),
  fontFamily: 'Jannah',
);
