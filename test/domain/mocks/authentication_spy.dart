import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/domain_error.dart';
import 'package:condominioapp/domain/usecases/authentication.dart';
import 'package:mocktail/mocktail.dart';

class AuthenticationSpy extends Mock implements Authentication {
  When mockAuthenticationCall() => when(() => auth(any()));
  void mockAuthetication(AccountEntity data) =>
      mockAuthenticationCall().thenAnswer((_) async => data);
  void mockAuthenticationError(DomainError error) =>
      mockAuthenticationCall().thenThrow(error);
}
