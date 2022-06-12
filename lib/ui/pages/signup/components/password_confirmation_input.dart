import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:condominioapp/ui/pages/pages.dart';

class PasswordConfirmationInput extends StatelessWidget {
  const PasswordConfirmationInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<String?>(
      stream: presenter.passwordConfirmationErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirmar Senha',
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.name,
          onChanged: presenter.validatePasswordConfirmation,
        );
      },
    );
  }
}
