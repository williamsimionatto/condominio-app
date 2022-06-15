import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../pages/sidebar/sidebar.dart';
import '../../pages/users/components/components.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Usuários"),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline2,
      ),
      body: ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                showSuccessMessage(context, "Usuário inativado com sucesso!");
                return;
              }
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Inativar usuário"),
                    content: const Text(
                        "Você tem certeza que deseja inativar o usuário?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        child: const Text("Inativar"),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  );
                },
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              color: AppColorsDark.warnigColor,
              child: const Icon(Icons.archive, color: Colors.white),
            ),
            child: const UserItem(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/users/add');
        },
      ),
    );
  }
}
