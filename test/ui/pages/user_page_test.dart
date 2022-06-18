import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class UserPresenterSpy extends Mock implements UserPresenter {}

void main() {
  late UserPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = UserPresenterSpy();

    final userPage = GetMaterialApp(
      initialRoute: '/user/any_user_id',
      getPages: [
        GetPage(name: '/user/:user_id', page: () => UserPage(presenter)),
        GetPage(
            name: '/users', page: () => const Scaffold(body: Text('Users'))),
      ],
    );
    await tester.pumpWidget(userPage);
  }

  testWidgets('Should call LoadUser on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
