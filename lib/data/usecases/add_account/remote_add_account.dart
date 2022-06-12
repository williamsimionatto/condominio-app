import '../../../domain/usecases/usecases.dart';

import '../../../data/http/http.dart';

class RemoteAddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({
    required this.httpClient,
    required this.url,
  });

  Future<void> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams entity) {
    return RemoteAddAccountParams(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      passwordConfirmation: entity.passwordConfirmation,
    );
  }

  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'passwordConfirmation': passwordConfirmation
      };
}
