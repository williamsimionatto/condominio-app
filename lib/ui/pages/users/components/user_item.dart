import 'package:flutter/material.dart';
import '../../../../ui/components/components.dart';
import '../../../pages/users/users.dart';

class UserItem extends StatelessWidget {
  late UserViewModel viewModel;

  UserItem(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(viewModel.name),
        trailing: const Icon(Icons.keyboard_arrow_right),
        iconColor: AppColorsDark.withColor,
      ),
    );
  }
}
