import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/ui/components/components.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<ValidationError?>(
      stream: presenter.nameErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Nome',
            labelStyle: const TextStyle(
              color: AppColorsDark.withColor,
              fontWeight: FontWeight.bold,
            ),
            icon: const Icon(Icons.person, color: AppColorsDark.withColor),
            errorText: snapshot.data?.description,
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.name,
          onChanged: presenter.validateName,
        );
      },
    );
  }
}
