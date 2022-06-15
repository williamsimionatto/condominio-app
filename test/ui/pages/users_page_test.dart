import 'dart:async';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class UsersPresenterSpy extends Mock implements UsersPresenter {}

void main() {
  late UsersPresenter presenter;
  late StreamController<bool> isLoadingController;
  late StreamController<List<UserViewModel>> loadUsersController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    loadUsersController = StreamController<List<UserViewModel>>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.loadUsersStream)
        .thenAnswer((_) => loadUsersController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    loadUsersController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = UsersPresenterSpy();
    initStreams();
    mockStreams();
    final userPage = GetMaterialApp(
      initialRoute: '/users',
      getPages: [
        GetPage(name: '/users', page: () => UsersPage(presenter)),
      ],
    );
    await tester.pumpWidget(userPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call LoadUsers on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should call handle loading correctly',
      (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should presenter error if loadUsersStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadUsersController.addError(DomainError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Usuário 1'), findsNothing);
  });
}
