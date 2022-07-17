import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {
  SaveCurrentAccountSpy() {
    mockSaveCurrentAccount();
  }

  When mockSaveCurrentAccountCall() => when(() => save(any()));
  void mockSaveCurrentAccount() =>
      mockSaveCurrentAccountCall().thenAnswer((_) async => _);
  void mockSaveCurrentAccountError(DomainError error) =>
      mockSaveCurrentAccountCall().thenReturn(error);
}
