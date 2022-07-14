import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';

class FakeParamsFactory {
  static AddAccountParams makeAddAccount() => AddAccountParams(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
        passwordConfirmation: faker.internet.password(),
        roleId: 1,
        cpf: '129.500.550-60',
        active: 'S',
      );

  static AuthenticationParams makeAuthentication() => AuthenticationParams(
        email: faker.internet.email(),
        secret: faker.internet.password(),
      );
}
