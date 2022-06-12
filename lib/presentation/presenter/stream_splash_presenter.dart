import 'dart:async';

import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

class SplashState {
  String? navigateTo;
}

class StreamSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  StreamController<SplashState>? _controller =
      StreamController<SplashState>.broadcast();
  final _state = SplashState();

  @override
  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();

  StreamSplashPresenter({
    required this.loadCurrentAccount,
  });

  @override
  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      _state.navigateTo = account.token.isEmpty == true ? '/login' : '/home';
      _update();
    } catch (error) {
      _state.navigateTo = '/login';
      _update();
    }
  }

  void _update() => _controller?.add(_state);
}
