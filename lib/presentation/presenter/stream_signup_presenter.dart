import 'dart:async';

import '../protocols/protocols.dart';

class SignUpState {
  String? email;
  String? name;
  String? password;

  String? emailError;
  String? nameError;
  String? passwordError;
  bool get isFormValid => false;
}

class StreamSignUpPresenter {
  final Validation validation;

  StreamController<SignUpState>? _controller =
      StreamController<SignUpState>.broadcast();
  final _state = SignUpState();

  Stream<String?>? get emailErrorStream =>
      _controller?.stream.map((state) => state.emailError).distinct();

  Stream<String?>? get nameErrorStream =>
      _controller?.stream.map((state) => state.nameError).distinct();

  Stream<String?>? get passwordErrorStream =>
      _controller?.stream.map((state) => state.passwordError).distinct();

  Stream<bool?>? get isFormValidStream =>
      _controller?.stream.map((state) => state.isFormValid).distinct();

  StreamSignUpPresenter({
    required this.validation,
  });

  void _update() => _controller?.add(_state);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validateName(String name) {
    _state.nameError = validation.validate(field: 'name', value: name);
    _update();
  }

  void validatePassword(String password) {
    _state.passwordError = validation.validate(
      field: 'password',
      value: password,
    );
    _update();
  }
}
