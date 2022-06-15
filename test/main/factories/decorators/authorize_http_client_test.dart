import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/cache/cache.dart';

class AUthorizeHttpClientDecorator {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  AUthorizeHttpClientDecorator({required this.fetchSecureCacheStorage});

  Future<void> request() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

class AuthorizeHttpClientDecoratorSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  late FetchSecureCacheStorage fetchSecureCacheStorage;
  late AUthorizeHttpClientDecorator sut;
  setUp(() {
    fetchSecureCacheStorage = AuthorizeHttpClientDecoratorSpy();

    sut = AUthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request();

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });
}
