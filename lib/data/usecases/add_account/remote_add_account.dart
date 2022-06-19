import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../../data/models/models.dart';
import '../../../data/http/http.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<UserEntity> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);

      return RemoteUserModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.emailInUse
          : DomainError.unexpected;
    }
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String active;
  final int roleId;
  final String cpf;

  RemoteAddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.active,
    required this.roleId,
    required this.cpf,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams entity) {
    return RemoteAddAccountParams(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      passwordConfirmation: entity.passwordConfirmation,
      active: entity.active,
      roleId: entity.roleId,
      cpf: entity.cpf,
    );
  }

  Map toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'active': active,
        'perfil_id': roleId,
        'cpf': cpf,
      };
}
