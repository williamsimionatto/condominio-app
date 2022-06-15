import 'dart:async';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

class UserState {
  bool? isLoading = false;
  late List<UserViewModel>? users;
}

class StreamUsersPresenter {
  final LoadUsers loadUsers;
  final bool isLoading = true;

  StreamController<UserState>? _controller =
      StreamController<UserState>.broadcast();

  final _state = UserState();

  Stream<bool?>? get isLoadingStream =>
      _controller?.stream.map((state) => state.isLoading).distinct();

  Stream<List<UserViewModel>?>? get loadUsersStream =>
      _controller?.stream.map((state) => state.users).distinct();

  StreamUsersPresenter({required this.loadUsers});

  Future<void> loadData() async {
    _state.isLoading = true;
    _update();
    final users = await loadUsers.load();
    _state.users = users
        .map(
          (user) => UserViewModel(
            id: user.id,
            name: user.name,
            email: user.email,
            active: user.active,
            cpf: user.cpf,
          ),
        )
        .toList();

    _state.isLoading = false;
    _update();
  }

  void _update() => _controller?.add(_state);
}

class LoadUsersSpy extends Mock implements LoadUsers {}

void main() {
  late LoadUsers loadUsers;
  late StreamUsersPresenter sut;
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

  setUp(() {
    loadUsers = LoadUsersSpy();
    sut = StreamUsersPresenter(loadUsers: loadUsers);
    mockLoadUsers(mockValidData());
  });

  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(loadUsers.load()).called(1);
  });

  test('Should emit correct events on success', () async* {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.loadUsersStream?.listen(expectAsync1((data) => expect(data, [
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
          ),
        ])));

    await sut.loadData();
  });
}
