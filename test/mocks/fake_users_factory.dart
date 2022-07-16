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
}
