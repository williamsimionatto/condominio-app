import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        const LoginHeader(),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            child: Column(children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  icon:
                      Icon(Icons.email, color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 32),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.lock,
                          color: Theme.of(context).primaryColor)),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: const Text('Entrar'),
              )
            ]),
          ),
        )
      ])),
    );
  }
}
