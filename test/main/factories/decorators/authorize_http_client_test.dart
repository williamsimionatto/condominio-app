import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/cache/cache.dart';

class AUthorizeHttpClientDecorator {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  AUthorizeHttpClientDecorator({required this.fetchSecureCacheStorage});

  Future<void> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

class AuthorizeHttpClientDecoratorSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  late FetchSecureCacheStorage fetchSecureCacheStorage;
  late AUthorizeHttpClientDecorator sut;
  late String url;
  late String method;
  late Map? body;

  setUp(() {
    fetchSecureCacheStorage = AuthorizeHttpClientDecoratorSpy();
    sut = AUthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
    );

    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });
}
