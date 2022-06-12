import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return Theme.of(context).primaryColorLight;
            } else {
              return Theme.of(context).primaryColor;
            }
          },
        ),
      ),
      onPressed: null,
      child: const Text('Adicionar'),
    );
  }
}
