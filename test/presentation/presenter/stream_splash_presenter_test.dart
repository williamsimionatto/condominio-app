import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/account_entity.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/ui/pages/pages.dart';

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
  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      _state.navigateTo = account != null ? '/login' : '/home';
      _update();
    } catch (error) {
      _state.navigateTo = '/login';
      _update();
    }
  }

  void _update() => _controller?.add(_state);
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  late StreamSplashPresenter sut;
  late LoadCurrentAccount loadCurrentAccount;

  PostExpectation mockLoadCurrentAccountCall() =>
      when(loadCurrentAccount.load());

  void mockLoadCurrentAccount({required AccountEntity account}) {
    mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow(Exception());
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = StreamSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(token: faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async* {
    sut.navigateToStream?.listen((page) => expect(page, '/home'));

    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async* {
    mockLoadCurrentAccount(account: null as AccountEntity);
    sut.navigateToStream?.listen((page) => expect(page, '/login'));

    await sut.checkAccount();
  });

  test('Should go to login page on error', () async* {
    mockLoadCurrentAccountError();
    sut.navigateToStream?.listen((page) => expect(page, '/login'));

    await sut.checkAccount();
  });
}
