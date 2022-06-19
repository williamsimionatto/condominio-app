import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/presentation/mixins/loading_manager.dart';
import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:get/get.dart';

import 'package:condominioapp/ui/pages/pages.dart';

class GetxUserPresenter extends GetxController
    with LoadingManager
    implements UserPresenter {
  final LoadUser loadUser;
  final String userId;

  final _user = Rx<UserViewModel?>(null);

  @override
  Stream<UserViewModel?>? get userStream => _user.stream;

  GetxUserPresenter({required this.loadUser, required this.userId});

  @override
  Future<void> loadData() async {
    try {
      isLoading = true;
      final userResult = await loadUser.loadByUser(userId: userId);
      _user.value = UserViewModel(
        id: userResult.id,
        name: userResult.name,
        email: userResult.email,
        active: userResult.active,
        cpf: userResult.cpf,
        roleId: userResult.roleId,
      );
    } on DomainError {
      _user.subject.addError(UIError.unexpected.description);
    } finally {
      isLoading = false;
    }
  }
}
