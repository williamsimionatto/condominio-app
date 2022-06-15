import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class UsersPresenterSpy extends Mock implements UsersPresenter {}

void main() {
  testWidgets('Should call LoadUsers on page load',
      (WidgetTester tester) async {
    final presenter = UsersPresenterSpy();

    final userPage = GetMaterialApp(
      initialRoute: '/users',
      getPages: [
        GetPage(name: '/users', page: () => UsersPage(presenter)),
      ],
    );

    await tester.pumpWidget(userPage);

    verify(presenter.loadData()).called(1);
  });
}
