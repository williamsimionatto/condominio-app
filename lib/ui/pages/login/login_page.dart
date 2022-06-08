import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        const LoginHeader(),
        Padding(
          padding: const EdgeInsets.all(38),
          child: Form(
            child: Column(children: <Widget>[
              StreamBuilder<String>(
                  stream: presenter.emailErrorStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        icon: Icon(Icons.email,
                            color: Theme.of(context).primaryColor),
                        errorText: snapshot.data?.isEmpty == true
                            ? null
                            : snapshot.data,
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: presenter.validateEmail,
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 32),
                child: StreamBuilder<String>(
                    stream: presenter.passwordErrorStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                            icon: Icon(Icons.lock,
                                color: Theme.of(context).primaryColor),
                            errorText: snapshot.data),
                        obscureText: true,
                        onChanged: presenter.validatePassword,
                        style: const TextStyle(color: Colors.white),
                      );
                    }),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Entrar'),
                ),
              )
            ]),
          ),
        )
      ])),
    );
  }
}
