import 'package:faker/faker.dart';

class ApiFactory {
  static Map makeAccountJson() => {
        'id': 1,
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'password': faker.internet.password(),
        'password_confirmation': faker.internet.password(),
        'active': faker.randomGenerator.element(['S', 'N']),
        'perfil_id': 1,
        'cpf': '129.500.550-60',
      };

  static Map makeApiAuthJson() => {
        'access_token': faker.guid.guid(),
        'name': faker.person.name(),
      };

  static Map makeUserJson() => {
        'id': faker.randomGenerator.integer(10, min: 1),
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'active': faker.randomGenerator.element(['S', 'N']),
        'cpf': faker.randomGenerator.string(11, min: 11),
        'perfil_id': faker.randomGenerator.integer(10, min: 1),
      };

  static List<Map> makeUsersList() => [
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

  static Map makeInvalidJson() => {'invalid_key': 'invalid_value'};

  static List<Map> makeInvalidList() =>
      [makeInvalidJson(), makeInvalidJson()];
}
