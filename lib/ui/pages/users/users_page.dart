import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';

import '../../pages/pages.dart';
import '../../pages/users/components/components.dart';
import '../../mixins/mixins.dart';

class UsersPage extends StatefulWidget {
  final UsersPresenter presenter;

  const UsersPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
    with LoadingManager, SessionManager, NavigationManager, RouteAware {
  @override
  Widget build(BuildContext context) {
    Get.find<RouteObserver>()
        .subscribe(this, ModalRoute.of(context) as PageRoute);
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
          handleLoading(context, widget.presenter.isLoadingStream);
          handleSessionExpired(widget.presenter.isSessionExpiredStream);
          handleNavigation(widget.presenter.navigateToStream);

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
                return RefreshIndicator(
                  onRefresh: () => widget.presenter.loadData(),
                  child: ListenableProvider<UsersPresenter>(
                    create: (_) => widget.presenter,
                    child: UserListView(users: snapshot.data!),
                  ),
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
          Get.toNamed("users/add");
        },
      ),
    );
  }

  @override
  void didPopNext() {
    widget.presenter.loadData();
  }

  @override
  void dispose() {
    Get.find<RouteObserver>().unsubscribe(this);
    super.dispose();
  }
}

class UserListView extends StatelessWidget {
  final List<UserViewModel> users;

  const UserListView({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: users.map((viewModel) => UserItem(viewModel)).toList());
  }
}
