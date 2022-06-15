import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_presenter.dart';
import '../../../../presentation/protocols/protocols.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<ValidationError?>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'E-mail',
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
            icon: Icon(Icons.email, color: Theme.of(context).primaryColor),
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
