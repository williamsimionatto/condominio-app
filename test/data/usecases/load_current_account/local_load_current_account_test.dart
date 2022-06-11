import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/data/cache/cache.dart';
import 'package:condominioapp/data/usecases/usecases.dart';

class FetchSecureStorageSpy extends Mock implements FetchSecureCacheStorage {}

void main() {
  late LocalLoadCurrentAccount sut;
  late FetchSecureCacheStorage fetchSecureCacheStorage;
  late String token;

  PostExpectation mockFetchSecureCacheStorageCall() =>
      when(fetchSecureCacheStorage.fetchSecure('token'));

  void mockFetchSecureCacheStorage(String token) {
    mockFetchSecureCacheStorageCall().thenAnswer((_) async => token);
  }

  void mockFetchSecureCacheStorageError(String token) {
    mockFetchSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureStorageSpy();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecureCacheStorage(token);
  });

  test('Should call FetchSecureCacheStorage with correct values', () async {
    await sut.load();
    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: token));
  });

  test('Should return an AccountEntity', () async {
    mockFetchSecureCacheStorageError(token);
    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
