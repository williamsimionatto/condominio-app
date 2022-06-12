import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/usecases/authentication.dart';
import 'package:condominioapp/data/http/http.dart';
import 'package:condominioapp/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAddAccount sut;
  late String url;
  late HttpClientSpy httpClient;
  late AddAccountParams params;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    final password = faker.internet.password();
    params = AddAccountParams(
      name: faker.person.name(),
      email: faker.internet.email(),
      password: password,
      passwordConfirmation: password,
    );
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
        'passwordConfirmation': params.passwordConfirmation,
      },
    ));
  });
}
