abstract class LoginPresenter {
  Stream<String> get emailErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
}
