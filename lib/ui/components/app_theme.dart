import 'package:flutter/material.dart';
import '../../ui/components/components.dart';

ThemeData makeAppTheme() {
  const inputDecorationTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.withColor)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColorsDark.withColor)),
    alignLabelWithHint: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  );

  final buttonTheme = ButtonThemeData(
    colorScheme: const ColorScheme.dark(primary: AppColorsDark.withColor),
    buttonColor: AppColorsDark.withColor,
    splashColor: AppColorsDark.withColor,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9),
    ),
  );

  const textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: AppColorsDark.primaryColor,
    ),
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColorsDark.withColor,
    ),
  );

  return ThemeData.dark().copyWith(
    primaryColor: AppColorsDark.primaryColor,
    backgroundColor: AppColorsDark.backgroundColor,
    primaryColorLight: AppColorsDark.primaryColorLight,
    disabledColor: AppColorsDark.primaryColorLight,
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    buttonTheme: buttonTheme,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColorsDark.withColor),
  );
}
