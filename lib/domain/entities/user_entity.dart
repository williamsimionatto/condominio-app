class UserEntity {
  final int id;
  final String name;
  final String email;
  final bool active;
  final String cpf;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.active,
    required this.cpf,
  });
}
