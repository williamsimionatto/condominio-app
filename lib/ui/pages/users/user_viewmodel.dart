import 'package:equatable/equatable.dart';

class UserViewModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String active;
  final String cpf;
  final int roleId;

  @override
  List get props => [id, name, email, active, cpf, roleId];

  const UserViewModel({
    required this.id,
    required this.name,
    required this.email,
    required this.active,
    required this.cpf,
    required this.roleId,
  });
}
