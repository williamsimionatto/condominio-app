import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/components.dart';

import '../../pages/pages.dart';
import '../../pages/users/components/components.dart';

class UsersPage extends StatefulWidget {
  final UsersPresenter presenter;

  const UsersPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
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
      body: Builder(
        builder: (BuildContext context) {
          widget.presenter.isLoadingStream?.listen((isLoading) async {
            if (isLoading == true) {
              await showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.isSessionExpiredStream?.listen((isExpired) {
            if (isExpired == true) {
              Get.offAllNamed('/login');
            }
          });

          widget.presenter.loadData();

          return StreamBuilder<List<UserViewModel>?>(
            stream: widget.presenter.usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: '${snapshot.error}',
                  reload: widget.presenter.loadData,
                );
              }

              if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: snapshot.data!
                      .map((viewModel) => UserItem(viewModel))
                      .toList(),
                );
              }

              return const SizedBox(height: 0);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.offNamed("users/add");
        },
      ),
    );
  }
}
