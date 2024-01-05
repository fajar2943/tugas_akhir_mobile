import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFFEECEC),
  100: Color(0xFFFCD0D1),
  200: Color(0xFFFBB0B2),
  300: Color(0xFFF99093),
  400: Color(0xFFF7797B),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFF5595C),
  700: Color(0xFFF34F52),
  800: Color(0xFFF24548),
  900: Color(0xFFEF3336),
});
const int _primaryPrimaryValue = 0xFFF66164;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFFCECF),
  700: Color(0xFFFFB5B6),
});
const int _primaryAccentValue = 0xFFFFFFFF;
