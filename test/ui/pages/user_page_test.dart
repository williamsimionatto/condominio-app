import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import '../helpers/helpers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late UserPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = UserPresenterSpy();

    await tester.pumpWidget(makePage(
      path: '/user/any_user_id',
      page: () => UserPage(presenter),
    ));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call LoadUser on page load', (WidgetTester tester) async {
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

  testWidgets('Should presenter error if loadUserStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUserError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
  });

  testWidgets('Should call LoadUsers on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUserError(UIError.unexpected.description);
    await tester.pump();

    await tester.tap(find.text('Recarregar'));

    verify(() => presenter.loadData()).called(2);
  });

  testWidgets('Should presenter valid data if loadUserStream succeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitUser(ViewModelFactory.makeUser());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing);
    expect(find.text('Recarregar'), findsNothing);
  });
}
