import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nome',
        labelStyle: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        icon: Icon(Icons.email, color: Theme.of(context).primaryColor),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.name,
    );
  }
}
