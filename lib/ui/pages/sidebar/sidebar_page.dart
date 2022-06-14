import 'package:condominioapp/ui/components/components.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text('Willim Simionatto',
                style: TextStyle(fontSize: 20, color: AppColorsDark.withColor)),
            accountEmail: Text('Administrador',
                style: TextStyle(fontSize: 15, color: AppColorsDark.withColor)),
            decoration: BoxDecoration(color: AppColorsDark.primaryColor),
          ),
          ListTile(
            title: Text('Usuários',
                style: TextStyle(fontSize: 15, color: AppColorsDark.withColor)),
          ),
          Divider(),
          ListTile(
            title: Text('Sair',
                style: TextStyle(fontSize: 15, color: AppColorsDark.withColor)),
            leading: Icon(Icons.exit_to_app, color: AppColorsDark.primaryColor),
          ),
        ],
      ),
    );
  }
}
