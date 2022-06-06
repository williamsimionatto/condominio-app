import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:condominioapp/ui/pages/pages.dart';

void main() {
  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    const loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
    expect(
      emailTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since of the childs is always the label text',
    );

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
    expect(
      passwordTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since of the childs is always the label text',
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });
}
