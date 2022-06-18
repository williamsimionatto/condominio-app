import 'dart:async';

import '../../pages/pages.dart';

abstract class UsersPresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<UserViewModel>?>? get usersStream;
  Stream<bool?>? get isSessionExpiredStream;
  Stream<String?>? get navigateToStream;

  Future<void> loadData();
  void goToUser(int userId);
}
