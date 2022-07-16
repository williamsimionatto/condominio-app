import 'package:condominioapp/domain/entities/user_entity.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:faker/faker.dart';

class FakeUserFactory {
  static Map makeApiJson() => {
        'id': faker.randomGenerator.integer(10, min: 1),
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'active': faker.randomGenerator.element(['S', 'N']),
        'cpf': faker.randomGenerator.string(11, min: 11),
        'perfil_id': faker.randomGenerator.integer(10, min: 1),
      };

  static Map makeInvalidApiJson() => {'invalid_key': 'invalid_value'};

  static UserEntity makeEntity() => UserEntity(
        id: faker.randomGenerator.integer(10, min: 1),
        name: faker.person.name(),
        email: faker.internet.email(),
        active: faker.randomGenerator.element(['S', 'N']),
        cpf: faker.randomGenerator.string(11, min: 11),
        roleId: faker.randomGenerator.integer(10, min: 1),
      );

  static UserViewModel makeViewModel() => const UserViewModel(
        id: 1,
        name: 'Teste',
        email: 'teste@mail.com',
        active: 'S',
        cpf: "123456789",
        roleId: 1,
      );
}
