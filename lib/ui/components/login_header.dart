import 'package:flutter/material.dart';

import './components.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 200),
        Headline1(
          text: 'Login',
        ),
      ],
    );
  }
}
