import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../signup_presenter.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<String?>(
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
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
