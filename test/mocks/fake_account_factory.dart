import 'package:faker/faker.dart';

class FakeAccountFactory {
  static Map mockApiJson() => {
        'id': 1,
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'password': faker.internet.password(),
        'password_confirmation': faker.internet.password(),
        'active': ['S', 'N'][faker.randomGenerator.integer(0, min: 1)],
        'perfil_id': 1,
        'cpf': '129.500.550-60',
      };

  static Map mockApiAuthJson() => {
        'access_token': faker.guid.guid(),
        'name': faker.person.name(),
      };
}
