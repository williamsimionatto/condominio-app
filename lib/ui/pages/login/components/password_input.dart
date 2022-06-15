import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<ValidationError?>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: const TextStyle(
                color: AppColorsDark.withColor,
                fontWeight: FontWeight.bold,
              ),
              icon: const Icon(Icons.email, color: AppColorsDark.withColor),
              errorText: snapshot.data?.description,
            ),
            obscureText: true,
            onChanged: presenter.validatePassword,
            style: const TextStyle(color: Colors.white),
          );
        });
  }
}
