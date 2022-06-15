import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../../../main/factories/usecases/usecases.dart';

UsersPresenter makeStreamUsersPresenter() =>
    StreamUsersPresenter(loadUsers: makeRemoteLoadUsers());
