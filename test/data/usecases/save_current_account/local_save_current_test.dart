import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

class SaveCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  late SaveCacheStorageSpy saveSecureCacheStorage;
  late AccountEntity account;
  late LocalSaveCurrentAccount sut;



  setUp(() {
    saveSecureCacheStorage = SaveCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);
    verify(
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    when(saveSecureCacheStorage.saveSecure(key: 'token', value: account.token))
        .thenThrow(Exception());

    final future = sut.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}
