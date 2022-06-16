import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../factories.dart';

LoginPresenter makeLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}
