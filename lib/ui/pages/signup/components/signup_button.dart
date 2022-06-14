import 'package:condominioapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<bool?>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
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
          onPressed: snapshot.data == true ? presenter.add : null,
          child: const Text('Entrar'),
        );
      },
    );
  }
}
