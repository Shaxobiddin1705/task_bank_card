import 'package:flutter/material.dart';

class CStyle{
  const CStyle._();

  static TextStyle cStyle({double? fontSize, double? fontWeight, Color? color}) => TextStyle(
    fontSize: fontSize ?? 14, fontWeight: fontWeight != null ? _defaultFontWeight[fontWeight] : FontWeight.w500, color: color ?? const Color(0xFFF1F1F1)
  );

  static final Map<int, FontWeight> _defaultFontWeight = {
    100: FontWeight.w100,
    200: FontWeight.w200,
    300: FontWeight.w300,
    400: FontWeight.w300,
    500: FontWeight.w400,
    600: FontWeight.w500,
    700: FontWeight.w600,
    800: FontWeight.w700,
    900: FontWeight.w800,
  };
}
