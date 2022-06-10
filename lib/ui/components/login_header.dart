import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
        margin: const EdgeInsets.only(bottom: 24, top: 32),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
        child: const Image(image: AssetImage('lib/ui/assets/logo.png')));
  }
}
