import '../../domain/entities/entities.dart';
import '../../data/http/http.dart';

class RemoteUserModel {
  final int id;
  final String name;
  final String email;
  final String active;
  final String cpf;
  final int roleId;

  RemoteUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.active,
    required this.cpf,
    required this.roleId,
  });

  factory RemoteUserModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(['id', 'name', 'email', 'active', 'cpf'])) {
      throw HttpError.invalidData;
    }

    return RemoteUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      active: json['active'],
      cpf: json['cpf'],
      roleId: json['perfil_id'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      active: active,
      cpf: cpf,
      roleId: roleId,
    );
  }
}
