import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../factories.dart';

SplashPresenter makeSplashPresenter() {
  return StreamSplashPresenter(
      loadCurrentAccount: makeLocalLoadCurrentAccount());
}
