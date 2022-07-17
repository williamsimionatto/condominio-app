import 'package:condominioapp/data/http/http_client.dart';
import 'package:condominioapp/data/http/http_error.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/cache/cache.dart';
import 'package:condominioapp/main/decorators/decorators.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

class DeleteSecureCacheStorageSpy extends Mock
    implements DeleteSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late HttpClient httpClient;
  late FetchSecureCacheStorage fetchSecureCacheStorage;
  late DeleteSecureCacheStorage deleteSecureCacheStorage;
  late AuthorizeHttpClientDecorator sut;
  late String url;
  late String method;
  late Map? body;
  late String token;
  late String httpResponse;

  void mockToken() {
    token = faker.jwt.valid();
    when(fetchSecureCacheStorage.fetch('token')).thenAnswer((_) async => token);
  }

  void mockTokenError() {
    when(fetchSecureCacheStorage.fetch('token')).thenThrow(Exception());
  }

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    when(httpClient.request(
      url: anyNamed('url') as String,
      method: anyNamed('method') as String,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => httpResponse);
  }

  void mockHttpResponseError(HttpError error) {
    when(httpClient.request(
      url: anyNamed('url') as String,
      method: anyNamed('method') as String,
      body: anyNamed('body'),
      headers: anyNamed('headers'),
    )).thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    deleteSecureCacheStorage = DeleteSecureCacheStorageSpy();
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      deleteSecureCacheStorage: deleteSecureCacheStorage,
      decoratee: httpClient,
    );

    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mockToken();
    mockHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetch('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);
    verify(httpClient.request(url: url, method: method, body: body, headers: {
      'Authorization': 'Bearer $token',
    })).called(1);

    await sut.request(url: url, method: method, body: body, headers: {
      'any_header': 'any_value',
    });
    verify(httpClient.request(url: url, method: method, body: body, headers: {
      'Authorization': 'Bearer $token',
      'any_header': 'any_value',
    })).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(url: url, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should thorw ForbiddenError if FetchSecureCacheStorage thorws',
      () async {
    mockTokenError();
    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('token')).called(1);
  });

  test('Should rethorw if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);
    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should delete cache if Request throws ForbiddenError', () async {
    mockHttpResponseError(HttpError.forbidden);
    final future = sut.request(url: url, method: method, body: body);
    await untilCalled(deleteSecureCacheStorage.delete('token'));

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('token')).called(1);
  });
}
