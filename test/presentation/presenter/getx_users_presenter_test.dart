import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetxUsersPresenter {
  final LoadUsers loadUsers;

  GetxUsersPresenter({required this.loadUsers});

  Future<void> loadData() async {
    await loadUsers.load();
  }
}

class LoadUsersSpy extends Mock implements LoadUsers {}

void main() {
  late LoadUsers loadUsers;
  late GetxUsersPresenter sut;

  setUp(() {
    loadUsers = LoadUsersSpy();
    sut = GetxUsersPresenter(loadUsers: loadUsers);
  });
  test('Should call LoadUsers on loadData', () async {
    await sut.loadData();
    verify(loadUsers.load()).called(1);
  });
}
