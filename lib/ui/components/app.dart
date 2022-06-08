import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    var backgroundColor = const Color(0xFF0E1D33);
    var primaryColor = const Color(0xFFEE4865);
    var primaryColorLight = const Color(0xFFFF7582);

    final inputDecorationTheme = InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: primaryColorLight)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );

    return MaterialApp(
      title: 'Madre Paulina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        backgroundColor: backgroundColor,
        primaryColorLight: primaryColorLight,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        inputDecorationTheme: inputDecorationTheme,
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLight,
          textTheme: ButtonTextTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
      ),
      home: LoginPage(null as LoginPresenter),
    );
  }
}
