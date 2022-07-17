import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../mocks/users_presenter_spy.dart';
import '../mocks/viewmodel.factory.dart';

void main() {
  late UsersPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = UsersPresenterSpy();
    await tester.pumpWidget(makePage(
      path: '/users',
      page: () => UsersPage(presenter),
    ));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call LoadUsers on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitLoading(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    presenter.emitLoading(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    presenter.emitLoading(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should presenter error if loadUsersStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUsersError(DomainError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Usuário 1'), findsNothing);
  });

  testWidgets('Should presenter list if loadUsersStream succeeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUsers(ViewModelFactory.makeUserList());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing);
    expect(find.text('Recarregar'), findsNothing);

    expect(find.text('Usuário 1'), findsOneWidget);
    expect(find.text('Usuário 2'), findsOneWidget);
  });

  testWidgets('Should call LoadUsers on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUsersError(DomainError.unexpected.description);
    await tester.pump();

    await tester.tap(find.text('Recarregar'));

    verify(() => presenter.loadData()).called(2);
  });

  testWidgets('Should call gotoUser on user click',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUsers(ViewModelFactory.makeUserList());
    await tester.pump();

    await tester.tap(find.text('Usuário 1'));
    await tester.pump();

    verify(() => presenter.goToUser(1)).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo('/any_route');
    await tester.pumpAndSettle();

    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSessionExpired(true);
    await tester.pumpAndSettle();
    expect(currentRoute, '/login');
  });

  testWidgets('Should not logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSessionExpired(false);
    await tester.pumpAndSettle();
    expect(currentRoute, '/users');
    await loadPage(tester);
  });
}
