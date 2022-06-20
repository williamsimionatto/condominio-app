import 'package:flutter/material.dart';
import '../components/components.dart';

void showSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColorsDark.successColor,
      content: Text(message, textAlign: TextAlign.center),
    ),
  );
}
