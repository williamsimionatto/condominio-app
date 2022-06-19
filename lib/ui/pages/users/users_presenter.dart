import 'dart:async';

import 'package:flutter/material.dart';

import '../../pages/pages.dart';

abstract class UsersPresenter implements Listenable {
  Stream<bool?>? get isLoadingStream;
  Stream<List<UserViewModel>?>? get usersStream;
  Stream<bool?>? get isSessionExpiredStream;
  Stream<String?>? get navigateToStream;

  Future<void> loadData();
  void goToUser(int userId);
}
