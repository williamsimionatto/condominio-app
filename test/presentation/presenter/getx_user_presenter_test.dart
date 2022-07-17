import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';

import '../../domain/mocks/entity_factory.dart';

class LoadUserSpy extends Mock implements LoadUser {}

void main() {
  late LoadUser loadUser;
  late GetxUserPresenter sut;
  late UserEntity user;
  late String userId;

  void mockLoadUser(UserEntity data) {
    user = data;
    when(loadUser.loadByUser(userId: anyNamed('userId') as String))
        .thenAnswer((_) async => data);
  }

  void mockLoadUserError() {
    when(loadUser.loadByUser(userId: anyNamed('userId') as String))
        .thenThrow(DomainError.unexpected);
  }

  setUp(() {
    userId = '1';
    loadUser = LoadUserSpy();
    sut = GetxUserPresenter(loadUser: loadUser, userId: userId);
    mockLoadUser(EntityFactory.makeUser());
  });

  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(loadUser.loadByUser(userId: userId)).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.userStream?.listen(expectAsync1((result) => expect(
        result,
        UserViewModel(
          id: user.id,
          name: user.name,
          email: user.email,
          active: user.active,
          cpf: user.cpf,
          roleId: user.roleId,
        ))));
    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    mockLoadUserError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.userStream?.listen(
      null,
      onError: expectAsync1(
        (error) => expect(error, UIError.unexpected.description),
      ),
    );

    await sut.loadData();
  });
}
