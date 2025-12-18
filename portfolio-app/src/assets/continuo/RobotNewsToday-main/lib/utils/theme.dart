import 'package:flutter/material.dart';

const continuoBlue = Color(0xFF0072CE);
const continuoAccent = Color(0xFFE8F3FF);
const continuoText = Color(0xFF001E3C);
const continuoBackground = Color(0xFFFFFFFF);

final continuoTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: continuoBlue,
  scaffoldBackgroundColor: continuoBackground,
  fontFamily: 'SF Pro Display',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: continuoText),
    displayMedium: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: continuoText),
    titleLarge: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w600, color: continuoText),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    labelLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: continuoBlue),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: continuoBlue,
    secondary: continuoAccent,
    surface: continuoBackground,
    onPrimary: Colors.white,
    onSecondary: continuoText,
  ),
  useMaterial3: true,
);
