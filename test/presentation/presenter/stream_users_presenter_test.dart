import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class StreamUsersPresenter {
  final LoadUsers loadUsers;

  StreamUsersPresenter({required this.loadUsers});

  Future<void> loadData() async {
    await loadUsers.load();
  }
}

class LoadUsersSpy extends Mock implements LoadUsers {}

void main() {
  test('Should call LoadUsers on loadData', () async {
    final loadUsers = LoadUsersSpy();
    final sut = StreamUsersPresenter(loadUsers: loadUsers);

    await sut.loadData();

    verify(loadUsers.load()).called(1);
  });
}
