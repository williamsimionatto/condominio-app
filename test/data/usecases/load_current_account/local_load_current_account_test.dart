import 'package:condominioapp/data/usecases/usecases.dart';
import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/domain_error.dart';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late LocalLoadCurrentAccount sut;
  late SecureCacheStorageSpy secureCacheStorage;
  late String token;

  setUp(() {
    token = faker.guid.guid();
    secureCacheStorage = SecureCacheStorageSpy();
    secureCacheStorage.mockFetch(token);
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: secureCacheStorage);
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(() => secureCacheStorage.fetch('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws',
      () async {
    secureCacheStorage.mockFetchError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage returns null',
      () async {
    secureCacheStorage.mockFetch(null);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
