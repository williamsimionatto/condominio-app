import 'package:condominioapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import '../components/components.dart';

class UserForm extends StatelessWidget {
  final UserViewModel user;
  const UserForm(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          NameInput(value: user.name),
        ],
      ),
    );
  }
}
