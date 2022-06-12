import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Senha',
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
