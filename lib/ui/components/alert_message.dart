import 'package:flutter/material.dart';
import '../components/components.dart';

void showAlertMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColorsDark.warnigColor,
      content: Text(error, textAlign: TextAlign.center),
    ),
  );
}
