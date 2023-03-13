import 'package:flutter/material.dart';
import 'package:task_bank_card/consts/styles.dart';

import 'colors.dart';

class CustomTheme{
  const CustomTheme._();

  static final ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: MyColors.primaryBackDark,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: CStyle.cStyle(fontSize: 20, fontWeight: 500, color: const Color(0xFFF1F1F1)),
      foregroundColor: const Color(0xFFF1F1F1),
      elevation: 0,
      backgroundColor: MyColors.primaryBackDark
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      height: 56,
      minWidth: double.infinity,
      buttonColor: Colors.white
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MyColors.darkBlue,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}