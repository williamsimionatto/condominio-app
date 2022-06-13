import 'dart:async';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class SignUpState {
  String? email;
  String? name;
  String? password;
  String? passwordConfirmation;
  String? navigateTo;
  bool? isLoading;

  String? emailError;
  String? nameError;
  String? passwordError;
  String? passwordConfirmationError;
  String? mainError;

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
  final SaveCurrentAccount saveCurrentAccount;

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

  Stream<bool?>? get isLoadingStream =>
      _controller?.stream.map((state) => state.isLoading).distinct();

  Stream<String?>? get mainErrorStream =>
      _controller?.stream.map((state) => state.mainError).distinct();

  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();

  StreamSignUpPresenter({
    required this.validation,
    required this.addAccount,
    required this.saveCurrentAccount,
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
    try {
      _state.isLoading = true;
      final account = await addAccount.add(AddAccountParams(
        name: _state.name!,
        email: _state.email!,
        password: _state.password!,
        passwordConfirmation: _state.passwordConfirmation!,
      ));

      await saveCurrentAccount.save(account);
      _state.navigateTo = '/users';
      _update();
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse:
          _state.mainError = error.description;
          break;
        default:
          _state.mainError = error.description;
          break;
      }
      _state.isLoading = false;
      _update();
    }
  }

  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
