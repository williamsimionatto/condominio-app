import 'dart:async';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

import '../protocols/protocols.dart';

class LoginState {
  String? email;
  String? password;
  bool? isLoading = false;

  ValidationError? emailError;
  ValidationError? passwordError;
  String? mainError;
  String? navigateTo;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  StreamController<LoginState>? _controller =
      StreamController<LoginState>.broadcast();
  final _state = LoginState();

  @override
  Stream<ValidationError?>? get emailErrorStream =>
      _controller?.stream.map((state) => state.emailError).distinct();

  @override
  Stream<ValidationError?>? get passwordErrorStream =>
      _controller?.stream.map((state) => state.passwordError).distinct();

  @override
  Stream<String?>? get mainErrorStream =>
      _controller?.stream.map((state) => state.mainError).distinct();

  @override
  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();

  @override
  Stream<bool?>? get isFormValidStream =>
      _controller?.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool?>? get isLoadingStream =>
      _controller?.stream.map((state) => state.isLoading).distinct();

  StreamLoginPresenter({
    required this.validation,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = _validateField('email');
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = _validateField('password');
    _update();
  }

  @override
  Future<void> auth() async {
    try {
      _state.mainError = null;
      _state.isLoading = true;
      _update();

      final account = await authentication.auth(
          AuthenticationParams(email: _state.email!, secret: _state.password!));
      await saveCurrentAccount.save(account!);

      _state.navigateTo = '/home';
      _update();
    } on DomainError catch (error) {
      _state.mainError = error.description;
      _state.isLoading = false;
      _update();
    }
  }

  ValidationError? _validateField(String field) {
    final formData = {
      'email': _state.email,
      'password': _state.password,
    };

    return validation.validate(field: field, input: formData);
  }

  void _update() => _controller?.add(_state);

  @override
  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
