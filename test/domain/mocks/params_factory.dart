import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';

class ParamsFactory {
  static AddAccountParams makeAddAccount() => AddAccountParams(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
        passwordConfirmation: faker.internet.password(),
        roleId: 1,
        cpf: '129.500.550-60',
        active: faker.randomGenerator.element(['S', 'N']),
      );

  static AuthenticationParams makeAuthentication() => AuthenticationParams(
        email: faker.internet.email(),
        secret: faker.internet.password(),
      );
}
