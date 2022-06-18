import 'package:condominioapp/ui/components/components.dart';
import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Senha',
            labelStyle: const TextStyle(
              color: AppColorsDark.withColor,
              fontWeight: FontWeight.bold,
            ),
            icon: const Icon(
              Icons.lock,
              color: AppColorsDark.withColor,
            ),
            errorText: snapshot.data?.description,
          ),
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      },
    );
  }
}
