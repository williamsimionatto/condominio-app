import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class UsersPresenterSpy extends Mock implements UsersPresenter {}

void main() {
  late UsersPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = UsersPresenterSpy();

    final userPage = GetMaterialApp(
      initialRoute: '/users',
      getPages: [
        GetPage(name: '/users', page: () => UsersPage(presenter)),
      ],
    );
    await tester.pumpWidget(userPage);
  }

  testWidgets('Should call LoadUsers on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
