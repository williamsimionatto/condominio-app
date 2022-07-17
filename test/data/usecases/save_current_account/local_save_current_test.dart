import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';

import 'package:condominioapp/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late SecureCacheStorageSpy secureCacheStorage;
  late AccountEntity account;
  late LocalSaveCurrentAccount sut;

  setUp(() {
    secureCacheStorage = SecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call secureCacheStorage with correct values', () async {
    await sut.save(account);
    verify(() => secureCacheStorage.save(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if secureCacheStorage throws', () async {
    secureCacheStorage.mockSaveError();

    final future = sut.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}
