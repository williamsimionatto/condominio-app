import 'dart:async';

import 'package:condominioapp/domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class SignUpState {
  String? email;
  String? name;
  String? password;
  String? passwordConfirmation;

  String? emailError;
  String? nameError;
  String? passwordError;
  String? passwordConfirmationError;
  bool get isFormValid =>
      nameError == '' &&
      emailError == '' &&
      passwordError == '' &&
      passwordConfirmationError == '' &&
      name != null &&
      email != null &&
      password != null &&
      passwordConfirmation != null;
}

class StreamSignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;

  StreamController<SignUpState>? _controller =
      StreamController<SignUpState>.broadcast();
  final _state = SignUpState();

  Stream<String?>? get emailErrorStream =>
      _controller?.stream.map((state) => state.emailError).distinct();

  Stream<String?>? get nameErrorStream =>
      _controller?.stream.map((state) => state.nameError).distinct();

  Stream<String?>? get passwordErrorStream =>
      _controller?.stream.map((state) => state.passwordError).distinct();

  Stream<String?>? get passwordConfirmationErrorStream => _controller?.stream
      .map((state) => state.passwordConfirmationError)
      .distinct();

  Stream<bool?>? get isFormValidStream =>
      _controller?.stream.map((state) => state.isFormValid).distinct();

  StreamSignUpPresenter({
    required this.validation,
    required this.addAccount,
  });

  void _update() => _controller?.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validateName(String name) {
    _state.name = name;
    _state.nameError = validation.validate(field: 'name', value: name);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(
      field: 'password',
      value: password,
    );
    _update();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _state.passwordConfirmation = passwordConfirmation;
    _state.passwordConfirmationError = validation.validate(
      field: 'passwordConfirmation',
      value: passwordConfirmation,
    );
    _update();
  }

  Future<void> add() async {
    await addAccount.add(AddAccountParams(
      name: _state.name!,
      email: _state.email!,
      password: _state.password!,
      passwordConfirmation: _state.passwordConfirmation!,
    ));
  }

  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
