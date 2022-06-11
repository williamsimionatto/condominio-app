import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    return AccountEntity(token: token);
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

  void mockFetchSecureCacheStorage(String token) {
    when(fetchSecureCacheStorage.fetchSecure('token'))
        .thenAnswer((_) async => token);
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
}
