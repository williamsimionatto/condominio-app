import 'package:condominioapp/ui/components/components.dart';
import 'package:flutter/material.dart';

class AppColorsDark implements AppColors {
  static const Color backgroundColor = Color(0xFF252422);
  static const Color primaryColor = Color(0xFFF24B4B);
  static const Color primaryColorLight = Color(0xFFFF7582);
  static const Color withColor = Color(0xFFF2F0D8);
  static const Color alertColor = Color(0xFFE74C3C);
  static const Color warnigColor = Color(0xFFF39C12);
  static const Color successColor = Color(0xFF30CB83);
  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return primaryColor;
        } else if (states.contains(MaterialState.disabled)) {
          return primaryColorLight;
        } else {
          return primaryColor;
        }
      },
    ),
  );
}
