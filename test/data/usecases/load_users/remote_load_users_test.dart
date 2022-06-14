import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/http/http.dart';

class RemoteLoadUsers {
  final String url;
  final HttpClient httpClient;

  RemoteLoadUsers({required this.url, required this.httpClient});

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct values', () async {
    final url = faker.internet.httpUrl();
    final httpClient = HttpClientSpy();
    final sut = RemoteLoadUsers(url: url, httpClient: httpClient);

    await sut.load();
    verify(httpClient.request(url: url, method: 'get'));
  });
}
