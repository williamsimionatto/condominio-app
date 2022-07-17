import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/entities/entities.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {
  late LoadUsersSpy loadUsers;
  late GetxUsersPresenter sut;
  late List<UserEntity> users;

  setUp(() {
    users = EntityFactory.makeUsers();
    loadUsers = LoadUsersSpy();
    loadUsers.mockLoad(users);
    sut = GetxUsersPresenter(loadUsers: loadUsers);
  });

  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(() => loadUsers.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.usersStream.listen(expectAsync1((usersData) => expect(usersData, [
          UserViewModel(
            id: users[0].id,
            name: users[0].name,
            email: users[0].email,
            active: users[0].active,
            cpf: users[0].cpf,
            roleId: users[0].roleId,
          ),
          UserViewModel(
            id: users[1].id,
            name: users[1].name,
            email: users[1].email,
            active: users[1].active,
            cpf: users[1].cpf,
            roleId: users[1].roleId,
          )
        ])));
    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    loadUsers.mockLoadError(DomainError.unexpected);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.usersStream.listen(
      null,
      onError: expectAsync1(
        (error) => expect(error, DomainError.unexpected.description),
      ),
    );

    await sut.loadData();
  });

  test('Should emit correct events on access denied', () async {
    loadUsers.mockLoadError(DomainError.accessDenied);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.isSessionExpiredStream, emits(true));

    await sut.loadData();
  });

  test('Should got to UserPage on user click', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/user/1')));

    sut.goToUser(1);
  });
}
