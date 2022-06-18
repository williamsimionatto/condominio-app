import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/entities/entities.dart';

import 'package:condominioapp/data/http/http.dart';
import 'package:condominioapp/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late String url;
  late HttpClient httpClient;
  late RemoteLoadUser sut;
  late Map user;

  Map mockValidData() => {
        'id': faker.randomGenerator.integer(10, min: 1),
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'active': faker.randomGenerator.element(['S', 'N']),
        'cpf': faker.randomGenerator.string(11, min: 11),
        'perfil_id': faker.randomGenerator.integer(10, min: 1),
      };

  PostExpectation mockRequest() =>
      when(httpClient.request(url: anyNamed('url') as String, method: 'get'));

  void mockHttpData(Map data) {
    user = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadUser(url: url, httpClient: httpClient);

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.loadByUser();
    verify(httpClient.request(url: url, method: 'get'));
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
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.loadByUser();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
