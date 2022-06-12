import 'package:flutter/material.dart';

class PasswordConfirmationInput extends StatelessWidget {
  const PasswordConfirmationInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Confirmar Senha',
        labelStyle: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        icon: Icon(
          Icons.lock,
          color: Theme.of(context).primaryColor,
        ),
      ),
      obscureText: true,
      style: const TextStyle(color: Colors.white),
    );
  }
}
