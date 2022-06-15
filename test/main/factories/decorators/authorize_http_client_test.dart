import 'package:condominioapp/data/http/http_client.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/cache/cache.dart';

class AUthorizeHttpClientDecorator {
  FetchSecureCacheStorage fetchSecureCacheStorage;
  HttpClient decoratee;

  AUthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.decoratee,
  });

  Future<void> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    final authorizedHeaders = {'Authorization': 'Bearer $token'};

    await decoratee.request(
        url: url, method: method, body: body, headers: authorizedHeaders);
  }
}

class AuthorizeHttpClientDecoratorSpy extends Mock
    implements FetchSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late FetchSecureCacheStorage fetchSecureCacheStorage;
  late AUthorizeHttpClientDecorator sut;
  late String url;
  late String method;
  late Map? body;
  late String token;

  void mockToken() {
    token = faker.jwt.valid();
    when(fetchSecureCacheStorage.fetchSecure('token'))
        .thenAnswer((_) async => token);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    fetchSecureCacheStorage = AuthorizeHttpClientDecoratorSpy();
    sut = AUthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      decoratee: httpClient,
    );

    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mockToken();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);

    verify(httpClient.request(url: url, method: method, body: body, headers: {
      'Authorization': 'Bearer $token',
    })).called(1);
  });
}
