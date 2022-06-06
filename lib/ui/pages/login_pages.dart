import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        const Image(image: AssetImage('lib/ui/assets/logo.png')),
        const Text('LOGIN'),
        Form(
          child: Column(children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'E-mail', icon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Senha', icon: Icon(Icons.lock)),
              obscureText: true,
            ),
            ElevatedButton(
              child: const Text('Entrar'),
              onPressed: () {},
            ),
          ]),
        )
      ])),
    );
  }
}
