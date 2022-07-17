import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/domain_error.dart';
import 'package:condominioapp/domain/usecases/add_account.dart';
import 'package:mocktail/mocktail.dart';

class AddAccountSpy extends Mock implements AddAccount {
  When mockAddAccountCall() => when(() => add(any()));

  void mockAddAccount(UserEntity data) =>
      mockAddAccountCall().thenAnswer((_) async => data);

  void mockAddAccountError(DomainError error) =>
      mockAddAccountCall().thenThrow(error);
}