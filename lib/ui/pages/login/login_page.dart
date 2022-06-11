import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
  void _hideKeyboard() {
    final currenctFocus = FocusScope.of(context);
    if (!currenctFocus.hasPrimaryFocus) {
      currenctFocus.unfocus();
    }
  }

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
        widget.presenter.isLoadingStream?.listen((isLoading) {
          if (isLoading == true) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.mainErrorStream?.listen((error) {
          if (error?.isNotEmpty == true) {
            showErrorMessage(context, error as String);
          }
        });

        widget.presenter.navigateToStream?.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page as String);
          }
        });

        return GestureDetector(
          onTap: _hideKeyboard,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const LoginHeader(),
                Padding(
                  padding: const EdgeInsets.all(38),
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: const <Widget>[
                          EmailInput(),
                          Padding(
                            padding: EdgeInsets.only(top: 24, bottom: 32),
                            child: PasswordInput(),
                          ),
                          Center(
                            child: LoginButton(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
