import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';

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
