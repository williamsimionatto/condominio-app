import 'package:condominioapp/ui/components/components.dart';
import 'package:condominioapp/ui/helpers/erros/errors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'E-mail',
            labelStyle: const TextStyle(
              color: AppColorsDark.withColor,
              fontWeight: FontWeight.bold,
            ),
            icon: const Icon(Icons.email, color: AppColorsDark.withColor),
            errorText: snapshot.data?.description,
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
