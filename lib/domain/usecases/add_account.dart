import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class AddAccount {
  Future<UserEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String active;
  final String cpf;
  final int roleId;

  @override
  List get props => [
        name,
        email,
        password,
        passwordConfirmation,
        roleId,
        active,
        cpf,
      ];

  const AddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.roleId,
    required this.cpf,
    required this.active,
  });
}
