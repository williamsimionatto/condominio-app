import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {
  When mockLoadCurrentAccountCall() => when(() => load());

  void mockLoadCurrentAccount({required AccountEntity account}) {
    mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow(Exception());
  }
}
