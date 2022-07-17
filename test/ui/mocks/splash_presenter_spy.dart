import 'dart:async';

import 'package:condominioapp/ui/pages/splash/splash_presenter.dart';
import 'package:mocktail/mocktail.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {
  final navigateToController = StreamController<String>();

  SplashPresenterSpy() {
    when(() => checkAccount()).thenAnswer((_) async => _);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);
  }

  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    navigateToController.close();
  }
}
