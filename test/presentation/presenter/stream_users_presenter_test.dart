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
  late LoadUsers loadUsers;
  late StreamUsersPresenter sut;

  setUp(() {
    loadUsers = LoadUsersSpy();
    sut = StreamUsersPresenter(loadUsers: loadUsers);
  });
  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(loadUsers.load()).called(1);
  });
}
