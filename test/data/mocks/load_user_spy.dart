import 'package:condominioapp/domain/entities/user_entity.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class LoadUserSpy extends Mock implements LoadUser {
  When mockLoadCall() => when(() => loadByUser(userId: any(named: 'userId')));
  void mockLoad(UserEntity user) =>
      mockLoadCall().thenAnswer((_) async => user);
  void mockLoadError() => mockLoadCall().thenThrow(DomainError.unexpected);
}
