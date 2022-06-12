import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  var backgroundColor = const Color(0xFF252422);
  var primaryColor = const Color(0xFFF24B4B);
  var primaryColorLight = const Color(0xFFFF7582);
  var withColor = const Color(0xFFF2F0D8);

  final inputDecorationTheme = InputDecorationTheme(
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: primaryColorLight)),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
    alignLabelWithHint: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  );

  final buttonTheme = ButtonThemeData(
    colorScheme: ColorScheme.dark(primary: primaryColor),
    buttonColor: primaryColor,
    splashColor: primaryColorLight,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9),
    ),
  );

  final textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: withColor,
    ),
  );

  return ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    primaryColorLight: primaryColorLight,
    disabledColor: primaryColorLight,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    buttonTheme: buttonTheme,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: withColor),
  );
}
