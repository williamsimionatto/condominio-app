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
  late RemoteLoadUsers sut;
  late List<Map> list;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadUsers(url: url, httpClient: httpClient);
    list = ApiFactory.makeUsersList();
    httpClient.mockRequest(list);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();
    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return users on 200', () async {
    final users = await sut.load();

    expect(users, [
      UserEntity(
        id: list[0]['id'],
        name: list[0]['name'],
        email: list[0]['email'],
        active: list[0]['active'],
        cpf: list[0]['cpf'],
        roleId: list[0]['perfil_id'],
      ),
      UserEntity(
        id: list[1]['id'],
        name: list[1]['name'],
        email: list[1]['email'],
        active: list[1]['active'],
        cpf: list[1]['cpf'],
        roleId: list[1]['perfil_id'],
      ),
    ]);
  });

  test(
      'Should return UnexpectError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest(ApiFactory.makeInvalidList());
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);
    final future = sut.load();
    expect(future, throwsA(DomainError.accessDenied));
  });
}
