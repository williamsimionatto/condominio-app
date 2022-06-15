import 'package:condominioapp/data/http/http_client.dart';
import 'package:condominioapp/data/http/http_error.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/cache/cache.dart';

class AUthorizeHttpClientDecorator implements HttpClient {
  FetchSecureCacheStorage fetchSecureCacheStorage;
  HttpClient decoratee;

  AUthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.decoratee,
  });

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer $token'});

      return await decoratee.request(
        url: url,
        method: method,
        body: body,
        headers: authorizedHeaders,
      );
    } on HttpError {
      rethrow;
    } catch (error) {
      throw HttpError.forbidden;
    }
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
  late String httpResponse;

  void mockToken() {
    token = faker.jwt.valid();
    when(fetchSecureCacheStorage.fetchSecure('token'))
        .thenAnswer((_) async => token);
  }

  void mockTokenError() {
    when(fetchSecureCacheStorage.fetchSecure('token')).thenThrow(Exception());
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
    fetchSecureCacheStorage = AuthorizeHttpClientDecoratorSpy();
    sut = AUthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
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

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
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
  });

  test('Should rethorw if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);
    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });
}
