import 'dart:async';

import 'package:condominioapp/ui/pages/users/users.dart';
import 'package:condominioapp/ui/pages/users/users_presenter.dart';
import 'package:mocktail/mocktail.dart';

class UsersPresenterSpy extends Mock implements UsersPresenter {
  final isLoadingController = StreamController<bool>();
  final isSessionExpiredController = StreamController<bool>();
  final loadUsersController = StreamController<List<UserViewModel>>();
  final navigateToController = StreamController<String>();

  UsersPresenterSpy() {
    when(() => loadData()).thenAnswer((_) async => _);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => usersStream).thenAnswer((_) => loadUsersController.stream);
    when(() => isSessionExpiredStream)
        .thenAnswer((_) => isSessionExpiredController.stream);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  }

  void emitUsers(List<UserViewModel> data) => loadUsersController.add(data);
  void emitUsersError(String error) => loadUsersController.addError(error);

  void emitLoading([bool show = true]) => isLoadingController.add(show);
  void emitSessionExpired([bool expired = true]) =>
      isSessionExpiredController.add(expired);
  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    isLoadingController.close();
    loadUsersController.close();
    isSessionExpiredController.close();
    navigateToController.close();
  }
}
