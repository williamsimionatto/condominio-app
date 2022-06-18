import 'dart:async';

import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get/get.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {
  late SignUpPresenter presenter;
  late StreamController<UIError> nameErrorController;
  late StreamController<UIError> emailErrorController;
  late StreamController<UIError> passwordErrorController;
  late StreamController<UIError> passwordConfirmationErrorController;
  late StreamController<String> navigateToController;
  late StreamController<UIError> mainErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;

  void initStreams() {
    nameErrorController = StreamController<UIError>();
    emailErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    passwordConfirmationErrorController = StreamController<UIError>();
    navigateToController = StreamController<String>();
    mainErrorController = StreamController<UIError>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
    navigateToController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterSpy();
    initStreams();
    mockStreams();

    final signUpPage = GetMaterialApp(
      initialRoute: '/users/add',
      getPages: [
        GetPage(name: '/users/add', page: () => SignUpPage(presenter)),
        GetPage(
          name: '/any_route',
          page: () => const Scaffold(body: Text('fake page')),
        ),
      ],
    );
    await tester.pumpWidget(signUpPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(
      of: find.bySemanticsLabel('Nome'),
      matching: find.byType(Text),
    );
    expect(
      nameTextChildren,
      findsOneWidget,
    );

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
    expect(
      emailTextChildren,
      findsOneWidget,
    );

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
      passwordTextChildren,
      findsOneWidget,
    );

    final passwordConfirmationTextChildren = find.descendant(
      of: find.bySemanticsLabel('Confirmar Senha'),
      matching: find.byType(Text),
    );
    expect(
      passwordConfirmationTextChildren,
      findsOneWidget,
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));

    await tester.enterText(find.bySemanticsLabel('Confirmar Senha'), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should presenter email error', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    emailErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    emailErrorController.add(null as UIError);
    await tester.pump();
    expect(
      find.descendant(
          of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should presenter name error', (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    nameErrorController.add(null as UIError);
    await tester.pump();
    expect(
      find.descendant(
          of: find.bySemanticsLabel('Nome'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should presenter password error', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    passwordErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    passwordErrorController.add(null as UIError);
    await tester.pump();
    expect(
      find.descendant(
          of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should presenter passwordConfirmation error',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordConfirmationErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    passwordConfirmationErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    passwordConfirmationErrorController.add(null as UIError);
    await tester.pump();
    expect(
      find.descendant(
          of: find.bySemanticsLabel('Confirmar Senha'),
          matching: find.byType(Text)),
      findsOneWidget,
    );
  });

  testWidgets('Should disabled button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);
    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should enabled button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);
    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should call add on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.add()).called(1);
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

  testWidgets('Should present error message if add fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.emailInUse);
    await tester.pump();

    expect(find.text('O e-mail já está sendo usado'), findsOneWidget);
  });

  testWidgets('Should present error message if add throws',
      (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.unexpected);
    await tester.pump();

    expect(
      find.text('Algo errado acounteu. Tentenovamente mais tarde'),
      findsOneWidget,
    );
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
    expect(Get.currentRoute, '/users/add');

    navigateToController.add(null as String);
    await tester.pump();
    expect(Get.currentRoute, '/users/add');
  });
}
