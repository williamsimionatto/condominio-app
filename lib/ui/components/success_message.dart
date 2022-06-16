import 'package:flutter/material.dart';
import '../components/components.dart';

void showSuccessMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColorsDark.successColor,
      content: Text(error, textAlign: TextAlign.center),
    ),
  );
}
