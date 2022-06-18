import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxSplashPresenter extends GetxController
    with NavigationManager
    implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final JWTValidator jwtValidator;

  GetxSplashPresenter({
    required this.loadCurrentAccount,
    required this.jwtValidator,
  });

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      if (account.token.isEmpty == true) {
        navigateTo = '/home';
      } else if (jwtValidator.hasExpired(account.token)) {
        navigateTo = '/login';
      } else {
        navigateTo = '/home';
      }
    } catch (error) {
      navigateTo = '/login';
    }
  }
}
