import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/ui/pages/pages.dart';

class SplashState {
  String? navigateTo;
}

class StreamSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  final StreamController<SplashState>? _controller =
      StreamController<SplashState>.broadcast();
  // final _state = SplashState();

  @override
  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();

  StreamSplashPresenter({
    required this.loadCurrentAccount,
  });

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();
    final sut = StreamSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
