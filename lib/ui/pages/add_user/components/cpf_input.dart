import 'package:condominioapp/ui/components/components.dart';
import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_user_presenter.dart';

class CPFInput extends StatelessWidget {
  const CPFInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AddUserPresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.cpfErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'CPF',
            labelStyle: const TextStyle(
              color: AppColorsDark.withColor,
              fontWeight: FontWeight.bold,
            ),
            icon: const Icon(Icons.email, color: AppColorsDark.withColor),
            errorText: snapshot.data?.description,
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: presenter.validateCpf,
        );
      },
    );
  }
}
