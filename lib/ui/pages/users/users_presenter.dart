import 'dart:async';

abstract class UsersPresenter {
  Stream<bool?>? get isLoadingStream;
  Future<void> loadData();
}
