import 'package:flutter/material.dart';
import '../../../../ui/components/components.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text("William Simionatto Nepomuceno"),
        subtitle: Text("Condômino"),
        trailing: Icon(Icons.keyboard_arrow_right),
        iconColor: AppColorsDark.withColor,
      ),
    );
  }
}
