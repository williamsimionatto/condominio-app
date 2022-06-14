import '../../../../presentation/presenter/presenter.dart';
import '../../../../ui/pages/pages.dart';

import '../../../../main/factories/pages/pages.dart';
import '../../../../main/factories/usecases/usecases.dart';

SignUpPresenter makeSignUpPresenter() => StreamSignUpPresenter(
    addAccount: makeRemoteAddAccount(),
    validation: makeSignUpValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount());
