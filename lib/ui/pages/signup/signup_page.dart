import 'package:flutter/material.dart';
import 'components/components.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: _hideKeyboard,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(38),
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
                          padding: EdgeInsets.only(top: 24, bottom: 32),
                          child: PasswordConfirmationInput(),
                        ),
                        Center(
                          child: SignUpButton(),
                        )
                      ],
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
