import 'package:condominioapp/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class EntityFactory {
  static AccountEntity makeAccount() => AccountEntity(token: faker.guid.guid());
}
