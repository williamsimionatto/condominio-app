import 'package:flutter/material.dart';
import '../components/components.dart';

void showErrorMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColorsDark.alertColor,
      content: Text(error, textAlign: TextAlign.center),
    ),
  );
}
