import 'package:condominioapp/domain/entities/user_entity.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:faker/faker.dart';

class FakeUsersFactory {
  static List<Map> makeApiJson() => [
        {
          'id': faker.randomGenerator.integer(10, min: 1),
          'name': faker.person.name(),
          'email': faker.internet.email(),
          'active': faker.randomGenerator.element(['S', 'N']),
          'cpf': faker.randomGenerator.string(11, min: 11),
          'perfil_id': faker.randomGenerator.integer(10, min: 1),
        },
        {
          'id': faker.randomGenerator.integer(10, min: 1),
          'name': faker.person.name(),
          'email': faker.internet.email(),
          'active': faker.randomGenerator.element(['S', 'N']),
          'cpf': faker.randomGenerator.string(11, min: 11),
          'perfil_id': faker.randomGenerator.integer(10, min: 1),
        }
      ];

  static List<Map> makeInvalidApiJson() => [
        {'invalid_key': 'invalid_value'}
      ];

  static List<UserEntity> makeEntities() => [
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

  static List<UserViewModel> makeViewModel() => [
        const UserViewModel(
          id: 1,
          name: 'Usuário 1',
          email: 'usuario1@mail.com',
          active: 'S',
          cpf: "123456789",
          roleId: 1,
        ),
        const UserViewModel(
          id: 2,
          name: 'Usuário 2',
          email: 'usuario@2mail.com',
          active: 'N',
          cpf: "123456789",
          roleId: 1,
        ),
      ];
}
