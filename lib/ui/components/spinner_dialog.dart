import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10),
              const Text(
                'Aguarde ... ',
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      );
    },
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) Navigator.of(context).pop();
}
