import 'package:condominioapp/domain/entities/entities.dart';

class RemoteUserModel {
  final int id;
  final String name;
  final String email;
  final bool active;
  final int cpf;

  RemoteUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.active,
    required this.cpf,
  });

  factory RemoteUserModel.fromJson(Map json) {
    return RemoteUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      active: json['active'],
      cpf: json['cpf'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      active: active,
      cpf: cpf,
    );
  }
}
