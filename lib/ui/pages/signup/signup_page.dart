import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'components/components.dart';

import 'package:condominioapp/ui/components/components.dart';
import 'package:condominioapp/ui/pages/pages.dart';

class SignUpPage extends StatefulWidget {
  final SignUpPresenter presenter;

  const SignUpPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Usuários"),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline2,
      ),
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream?.listen((isLoading) async {
          if (isLoading == true) {
            await showLoading(context);
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
                Padding(
                  padding: const EdgeInsets.all(38),
                  child: Provider(
                    create: (_) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: const <Widget>[
                          NameInput(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: EmailInput(),
                          ),
                          PasswordInput(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: PasswordConfirmationInput(),
                          ),
                          Center(
                            child: SignUpButton(),
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
