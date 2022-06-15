import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

class GetxUsersPresenter {
  final LoadUsers loadUsers;

  final _isLoading = true.obs;
  final _users = Rx<List<UserViewModel>>([]);

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<List<UserViewModel>> get usersStream => _users.stream;

  GetxUsersPresenter({required this.loadUsers});

  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      final users = await loadUsers.load();
      _users.value = users
          .map((user) => UserViewModel(
                id: user.id,
                name: user.name,
                email: user.email,
                active: user.active,
                cpf: user.cpf,
              ))
          .toList();
    } on DomainError {
      _users.subject.addError(DomainError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}

class LoadUsersSpy extends Mock implements LoadUsers {}

void main() {
  late LoadUsers loadUsers;
  late GetxUsersPresenter sut;
  late List<UserEntity> users;

  List<UserEntity> mockValidData() => [
        const UserEntity(
          id: 1,
          name: 'Usuário 1',
          email: 'usuario1@mail.com',
          active: true,
          cpf: 123456789,
        ),
        const UserEntity(
          id: 1,
          name: 'Usuário 1',
          email: 'usuario1@mail.com',
          active: true,
          cpf: 123456789,
        ),
      ];

  void mockLoadUsers(List<UserEntity> data) {
    users = data;
    when(loadUsers.load()).thenAnswer((_) async => data);
  }

  void mockLoadUsersError() {
    when(loadUsers.load()).thenThrow(DomainError.unexpected);
  }

  setUp(() {
    loadUsers = LoadUsersSpy();
    sut = GetxUsersPresenter(loadUsers: loadUsers);
    mockLoadUsers(mockValidData());
  });

  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(loadUsers.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.usersStream.listen(expectAsync1((users) => expect(users, [
          UserViewModel(
            id: users[0].id,
            name: users[0].name,
            email: users[0].email,
            active: users[0].active,
            cpf: users[0].cpf,
          ),
          UserViewModel(
            id: users[1].id,
            name: users[1].name,
            email: users[1].email,
            active: users[1].active,
            cpf: users[1].cpf,
          )
        ])));
    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    mockLoadUsersError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.usersStream.listen(
      null,
      onError: expectAsync1(
        (error) => expect(error, DomainError.unexpected.description),
      ),
    );

    await sut.loadData();
  });
}
