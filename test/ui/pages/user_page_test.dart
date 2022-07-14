import 'dart:async';

import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import '../helpers/helpers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class UserPresenterSpy extends Mock implements UserPresenter {}

void main() {
  late UserPresenterSpy presenter;

  late StreamController<bool> isLoadingController;
  late StreamController<UserViewModel> loadUserController;

  UserViewModel makeUserResult() => const UserViewModel(
        id: 1,
        name: 'Teste',
        email: 'teste@mail.com',
        active: 'S',
        cpf: "123456789",
        roleId: 1,
      );

  void initStreams() {
    isLoadingController = StreamController<bool>();
    loadUserController = StreamController<UserViewModel>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);

    when(presenter.userStream).thenAnswer((_) => loadUserController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    loadUserController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = UserPresenterSpy();
    initStreams();
    mockStreams();

    await tester.pumpWidget(makePage(
      path: '/user/any_user_id',
      page: () => UserPage(presenter),
    ));
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call LoadUser on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should presenter error if loadUserStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadUserController.addError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
  });

  testWidgets('Should call LoadUsers on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadUserController.addError(UIError.unexpected.description);
    await tester.pump();

    await tester.tap(find.text('Recarregar'));

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should presenter valid data if loadUserStream succeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    loadUserController.add(makeUserResult());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing);
    expect(find.text('Recarregar'), findsNothing);
  });
}
