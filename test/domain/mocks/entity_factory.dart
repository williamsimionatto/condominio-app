import 'package:condominioapp/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class EntityFactory {
  static AccountEntity makeAccount() => AccountEntity(token: faker.guid.guid());

  static UserEntity makeUser() => UserEntity(
        id: faker.randomGenerator.integer(10, min: 1),
        name: faker.person.name(),
        email: faker.internet.email(),
        active: faker.randomGenerator.element(['S', 'N']),
        cpf: faker.randomGenerator.string(11, min: 11),
        roleId: faker.randomGenerator.integer(10, min: 1),
      );

  static List<UserEntity> makeUsers() => [
        const UserEntity(
          id: 1,
          name: 'Usuário 1',
          email: 'usuario1@mail.com',
          active: 'S',
          cpf: "123456789",
          roleId: 1,
        ),
        const UserEntity(
          id: 1,
          name: 'Usuário 1',
          email: 'usuario1@mail.com',
          active: 'S',
          cpf: "123456789",
          roleId: 1,
        ),
      ];
}
