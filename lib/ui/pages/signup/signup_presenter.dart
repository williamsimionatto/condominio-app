abstract class SignUpPresenter {
  Stream<String?>? get nameErrorStream;
  Stream<String?>? get emailErrorStream;
  Stream<String?>? get passwordErrorStream;
  Stream<String?>? get passwordConfirmationErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;
  Stream<String?>? get mainErrorStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);

  Future<void> add();

  void dispose();
}
