import 'package:condominioapp/presentation/protocols/validation.dart';

abstract class LoginPresenter {
  Stream<ValidationError?>? get emailErrorStream;
  Stream<ValidationError?>? get passwordErrorStream;
  Stream<String?>? get mainErrorStream;
  Stream<String?>? get navigateToStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  void dispose();
}
