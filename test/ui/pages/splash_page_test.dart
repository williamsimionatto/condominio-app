import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:mockito/mockito.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Condomínio Madre Paulina'),
      ),
      body: Builder(builder: (context) {
        presenter.navigateToStream?.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page as String);
          }
        });

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

abstract class SplashPresenter {
  Stream<String?>? get navigateToStream;
  Future<void> loadCurrentAccount();
}

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  late SplashPresenterSpy presenter;
  late StreamController<String> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    navigateToController = StreamController<String>();

    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);

    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        GetPage(
          name: '/any_route',
          page: () => const Scaffold(body: Text('fake page')),
        ),
      ],
    ));
  }

  tearDown(() {
    navigateToController.close();
  });

  testWidgets('Should presenter spinner on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadCurrentAccount()).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/');

    navigateToController.add(null as String);
    await tester.pump();
    expect(Get.currentRoute, '/');
  });
}
