import 'package:condominioapp/ui/mixins/loading_manager.dart';
import 'package:flutter/material.dart';

import '../../pages/pages.dart';

class UserPage extends StatelessWidget with LoadingManager {
  final UserPresenter presenter;

  const UserPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Usuário"),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline2,
      ),
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        presenter.loadData();

        return const Text("User Page");
      }),
    );
  }
}
