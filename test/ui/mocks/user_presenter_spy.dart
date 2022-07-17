import 'dart:async';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

class UserPresenterSpy extends Mock implements UserPresenter {
  final isLoadingController = StreamController<bool>();
  final loadUserController = StreamController<UserViewModel>();

  UserPresenterSpy() {
    when(() => loadData()).thenAnswer((_) async => _);
    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => userStream).thenAnswer((_) => loadUserController.stream);
  }

  void emitUser(UserViewModel data) => loadUserController.add(data);
  void emitUserError(String error) => loadUserController.addError(error);

  void emitLoading([bool show = true]) => isLoadingController.add(show);

  void dispose() {
    isLoadingController.close();
    loadUserController.close();
  }
}
