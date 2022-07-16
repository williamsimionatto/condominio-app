import 'package:faker/faker.dart';

class FakeAccountFactory {
  static Map mockApiJson() => {
        'id': 1,
        'name': faker.person.name(),
        'email': faker.internet.email(),
        'password': faker.internet.password(),
        'password_confirmation': faker.internet.password(),
        'active': faker.randomGenerator.element(['S', 'N']),
        'perfil_id': 1,
        'cpf': '129.500.550-60',
      };

  static Map mockApiAuthJson() => {
        'access_token': faker.guid.guid(),
        'name': faker.person.name(),
      };
}
