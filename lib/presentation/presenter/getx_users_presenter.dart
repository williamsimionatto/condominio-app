import 'package:get/get.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../../ui/pages/pages.dart';

class GetxUsersPresenter extends GetxController implements UsersPresenter {
  final LoadUsers loadUsers;

  final _isLoading = true.obs;
  final _isSessionExpired = RxBool(false);
  final _users = Rx<List<UserViewModel>>([]);

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Stream<bool?>? get isSessionExpiredStream => _isSessionExpired.stream;

  @override
  Stream<List<UserViewModel>> get usersStream =>
      _users.stream.map((users) => users.toList());

  GetxUsersPresenter({required this.loadUsers});

  @override
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
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _isSessionExpired.value = true;
      } else {
        _users.subject.addError(
          DomainError.unexpected.description,
          StackTrace.empty,
        );
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
