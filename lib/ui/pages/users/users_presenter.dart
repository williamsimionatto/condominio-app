import 'dart:async';

import '../../pages/pages.dart';

abstract class UsersPresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<UserViewModel>>? get loadUsersStream;
  Stream<String?>? get mainErrorStream;

  Future<void> loadData();
}
