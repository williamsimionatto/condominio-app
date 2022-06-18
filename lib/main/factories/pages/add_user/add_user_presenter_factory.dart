import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../../../main/factories/pages/pages.dart';
import '../../../../main/factories/usecases/usecases.dart';

AddUserPresenter makeAddUserPresenter() => GetxAddUserPresenter(
    addAccount: makeRemoteAddAccount(),
    validation: makeAddUserValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount());
