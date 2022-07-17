import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {
  late LoadUserSpy loadUser;
  late GetxUserPresenter sut;
  late UserEntity user;
  late String userId;

  setUp(() {
    user = EntityFactory.makeUser();
    userId = '1';
    loadUser = LoadUserSpy();
    loadUser.mockLoad(user);
    sut = GetxUserPresenter(loadUser: loadUser, userId: userId);
  });

  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(() => loadUser.loadByUser(userId: userId)).called(1);
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
    loadUser.mockLoadError();

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
