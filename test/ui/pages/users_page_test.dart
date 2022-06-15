import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class UsersPresenterSpy extends Mock implements UsersPresenter {}

void main() {
  late UsersPresenter presenter;
  late StreamController<bool> isLoadingController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
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
}
