import 'package:condominioapp/presentation/protocols/validation.dart';

abstract class SignUpPresenter {
  Stream<ValidationError?>? get nameErrorStream;
  Stream<ValidationError?>? get emailErrorStream;
  Stream<ValidationError?>? get passwordErrorStream;
  Stream<ValidationError?>? get passwordConfirmationErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;
  Stream<String?>? get mainErrorStream;
  Stream<String?>? get navigateToStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);

  Future<void> add();

  void dispose();
}
