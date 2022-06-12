abstract class SignUpPresenter {
  Stream<String?>? get nameErrorStream;
  Stream<String?>? get emailErrorStream;
  Stream<String?>? get passwordErrorStream;
  Stream<String?>? get passwordConfirmationErrorStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);

  void dispose();
}
