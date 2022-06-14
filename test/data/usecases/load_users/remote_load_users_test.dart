import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/data/models/models.dart';
import 'package:condominioapp/data/http/http.dart';

class RemoteLoadUsers {
  final String url;
  final HttpClient<List<Map>> httpClient;

  RemoteLoadUsers({required this.url, required this.httpClient});

  Future<List<UserEntity>> load() async {
    final httpResponse = await httpClient.request(url: url, method: 'get');

    return httpResponse!
        .map((json) => RemoteUserModel.fromJson(json).toEntity())
        .toList();
  }
}

class HttpClientSpy extends Mock implements HttpClient<List<Map>> {}

void main() {
  late String url;
  late HttpClient httpClient;
  late RemoteLoadUsers sut;
  late List<Map> list;

  List<Map> mockValidData() => [
        {
          'id': faker.randomGenerator.integer(10, min: 1),
          'name': faker.person.name(),
          'email': faker.internet.email(),
          'active': faker.randomGenerator.boolean(),
          'cpf': faker.randomGenerator.integer(11, min: 11)
        },
        {
          'id': faker.randomGenerator.integer(10, min: 1),
          'name': faker.person.name(),
          'email': faker.internet.email(),
          'active': faker.randomGenerator.boolean(),
          'cpf': faker.randomGenerator.integer(11, min: 11)
        }
      ];

  PostExpectation mockRequest() =>
      when(httpClient.request(url: anyNamed('url') as String, method: 'get'));

  void mockHttpData(List<Map> data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadUsers(
        url: url, httpClient: httpClient as HttpClient<List<Map>>);

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();
    verify(httpClient.request(url: url, method: 'get'));
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
      ),
      UserEntity(
        id: list[1]['id'],
        name: list[1]['name'],
        email: list[1]['email'],
        active: list[1]['active'],
        cpf: list[1]['cpf'],
      ),
    ]);
  });
}
