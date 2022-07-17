import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/entities/entities.dart';

import 'package:condominioapp/data/http/http.dart';
import 'package:condominioapp/data/usecases/usecases.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteLoadUser sut;
  late Map user;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadUser(url: url, httpClient: httpClient);
    user = ApiFactory.makeUserJson();
    httpClient.mockRequest(user);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.loadByUser();
    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return users on 200', () async {
    final result = await sut.loadByUser();

    expect(
        result,
        UserEntity(
          id: user['id'],
          name: user['name'],
          email: user['email'],
          active: user['active'],
          cpf: user['cpf'],
          roleId: user['roleId'],
        ));
  });

  test(
      'Should return UnexpectError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest(ApiFactory.makeInvalidJson());

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
