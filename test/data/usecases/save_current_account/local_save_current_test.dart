import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';

import 'package:condominioapp/data/usecases/usecases.dart';
import 'package:condominioapp/data/cache/cache.dart';

class SaveCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  late SaveCacheStorageSpy saveSecureCacheStorage;
  late AccountEntity account;
  late LocalSaveCurrentAccount sut;

  void mockError() {
    when(() => saveSecureCacheStorage.save(key: 'token', value: account.token))
        .thenThrow(Exception());
  }

  setUp(() {
    saveSecureCacheStorage = SaveCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);
    verify(
        () => saveSecureCacheStorage.save(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    mockError();

    final future = sut.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}
