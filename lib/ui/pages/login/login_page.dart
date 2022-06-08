import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'login_presenter.dart';
import 'components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.mainErrorStream.listen((error) {
          if (error.isNotEmpty) {
            showErrorMessage(context, error);
          }
        });

        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const LoginHeader(),
              Padding(
                padding: const EdgeInsets.all(38),
                child: Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        const EmailInput(),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 32),
                          child: StreamBuilder<String>(
                              stream: widget.presenter.passwordErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    icon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                  ),
                                  obscureText: true,
                                  onChanged: widget.presenter.validatePassword,
                                  style: const TextStyle(color: Colors.white),
                                );
                              }),
                        ),
                        Center(
                          child: StreamBuilder<bool>(
                              stream: widget.presenter.isFormValidStream,
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: snapshot.data == true
                                      ? widget.presenter.auth
                                      : null,
                                  child: const Text('Entrar'),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
