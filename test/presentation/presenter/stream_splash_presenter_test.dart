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
  final _state = SplashState();

  @override
  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();

  StreamSplashPresenter({
    required this.loadCurrentAccount,
  });

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
    _state.navigateTo = '/home';
  }

  void _update() => _controller?.add(_state);
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  late StreamSplashPresenter sut;
  late LoadCurrentAccount loadCurrentAccount;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = StreamSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async* {
    sut.navigateToStream?.listen((page) => expect(page, '/home'));

    await sut.checkAccount();
  });
}
