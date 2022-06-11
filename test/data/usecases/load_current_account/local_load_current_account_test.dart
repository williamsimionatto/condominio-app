import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/domain_error.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure(String key);
}

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
