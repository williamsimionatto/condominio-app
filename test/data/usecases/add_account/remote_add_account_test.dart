import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

import 'package:condominioapp/data/http/http.dart';
import 'package:condominioapp/data/usecases/usecases.dart';
import '../../../infra/mocks/mocks.dart';
import '../../../mocks/mocks.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAddAccount sut;
  late String url;
  late HttpClientSpy httpClient;
  late AddAccountParams params;
  late Map apiResult;

  PostExpectation mockRequest() => when(
      httpClient.request(url: url, method: 'post', body: anyNamed("body")));

  void mockHttpData(Map data) {
    apiResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    params = FakeParamsFactory.makeAddAccount();

    mockHttpData(ApiFactory.makeAccountJson());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);
    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'password_confirmation': params.passwordConfirmation,
        'active': params.active,
        'perfil_id': params.roleId,
        'cpf': params.cpf,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.emailInUse));
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 wiht invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final account = await sut.add(params);
    expect(account.email, apiResult['email']);
  });
}
