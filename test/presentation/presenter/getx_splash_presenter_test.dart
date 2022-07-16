import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';

import '../../mocks/mocks.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

class JWTValidatorSpy extends Mock implements JWTValidator {}

void main() {
  late GetxSplashPresenter sut;
  late LoadCurrentAccount loadCurrentAccount;
  late JWTValidator jwtValidator;

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
    jwtValidator = JWTValidatorSpy();
    sut = GetxSplashPresenter(
      loadCurrentAccount: loadCurrentAccount,
      jwtValidator: jwtValidator,
    );
    mockLoadCurrentAccount(account: FakeAccountFactory.makeEntity());
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async* {
    sut.navigateToStream.listen((page) => expect(page, '/home'));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null result', () async* {
    mockLoadCurrentAccount(account: null as AccountEntity);
    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async* {
    mockLoadCurrentAccountError();
    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
