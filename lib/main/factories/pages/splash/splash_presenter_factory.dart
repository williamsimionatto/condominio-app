import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../factories.dart';

SplashPresenter makeSplashPresenter() {
  return GetxSplashPresenter(
    loadCurrentAccount: makeLocalLoadCurrentAccount(),
    jwtValidator: makeJWTValidator(),
  );
}
