import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/usecases/usecases.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';

import '../../domain/mocks/mocks.dart';

class JWTValidatorSpy extends Mock implements JWTValidator {}

void main() {
  late GetxSplashPresenter sut;
  late LoadCurrentAccountSpy loadCurrentAccount;
  late JWTValidator jwtValidator;

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    loadCurrentAccount.mockLoadCurrentAccount(
        account: EntityFactory.makeAccount());

    jwtValidator = JWTValidatorSpy();
    sut = GetxSplashPresenter(
      loadCurrentAccount: loadCurrentAccount,
      jwtValidator: jwtValidator,
    );
  });

  setUpAll(() {
    registerFallbackValue(ParamsFactory.makeAddAccount());
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(() => loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async* {
    sut.navigateToStream.listen((page) => expect(page, '/home'));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async* {
    loadCurrentAccount.mockLoadCurrentAccountError();
    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
