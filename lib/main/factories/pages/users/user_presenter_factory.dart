import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../../../main/factories/usecases/usecases.dart';

UserPresenter makeGetxUserPresenter(String userId) => GetxUserPresenter(
      loadUser: makeRemoteLoadUser(userId),
      userId: userId,
    );
