import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
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
            onPressed: snapshot.data == true ? presenter.auth : null,
            child: const Text('Entrar'),
          );
        });
  }
}
