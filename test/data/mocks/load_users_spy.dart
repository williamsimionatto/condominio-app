import 'package:condominioapp/domain/entities/user_entity.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class LoadUsersSpy extends Mock implements LoadUsers {
  When mockLoadCall() => when(() => load());
  void mockLoad(List<UserEntity> users) =>
      mockLoadCall().thenAnswer((_) async => users);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
