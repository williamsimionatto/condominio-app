import 'dart:async';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/ui/pages/pages.dart';

import '../protocols/protocols.dart';

class SignUpState {
  String? email;
  String? name;
  String? password;
  String? passwordConfirmation;
  String? navigateTo;
  bool? isLoading;

  ValidationError? emailError;
  ValidationError? nameError;
  ValidationError? passwordError;
  ValidationError? passwordConfirmationError;
  String? mainError;

  bool get isFormValid =>
      nameError == null &&
      emailError == null &&
      passwordError == null &&
      passwordConfirmationError == null &&
      name != null &&
      email != null &&
      password != null &&
      passwordConfirmation != null;
}

class StreamSignUpPresenter implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  StreamController<SignUpState>? _controller =
      StreamController<SignUpState>.broadcast();
  final _state = SignUpState();

  @override
  Stream<ValidationError?>? get emailErrorStream =>
      _controller?.stream.map((state) => state.emailError).distinct();
  @override
  Stream<ValidationError?>? get nameErrorStream =>
      _controller?.stream.map((state) => state.nameError).distinct();
  @override
  Stream<ValidationError?>? get passwordErrorStream =>
      _controller?.stream.map((state) => state.passwordError).distinct();
  @override
  Stream<ValidationError?>? get passwordConfirmationErrorStream =>
      _controller?.stream
          .map((state) => state.passwordConfirmationError)
          .distinct();
  @override
  Stream<bool?>? get isFormValidStream =>
      _controller?.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool?>? get isLoadingStream =>
      _controller?.stream.map((state) => state.isLoading).distinct();
  @override
  Stream<String?>? get mainErrorStream =>
      _controller?.stream.map((state) => state.mainError).distinct();
  @override
  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();

  StreamSignUpPresenter({
    required this.validation,
    required this.addAccount,
    required this.saveCurrentAccount,
  });

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = _validateField('email');
    _update();
  }

  @override
  void validateName(String name) {
    _state.name = name;
    _state.nameError = _validateField('name');
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = _validateField('password');
    _update();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _state.passwordConfirmation = passwordConfirmation;
    _state.passwordConfirmationError = _validateField('passwordConfirmation');
    _update();
  }

  @override
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

  ValidationError _validateField(String field) {
    final formData = {
      'name': _state.name,
      'email': _state.email,
      'password': _state.password,
      'passwordConfirmation': _state.passwordConfirmation,
    };

    final error = validation.validate(field: field, input: formData);

    return error ?? null as ValidationError;
  }

  void _update() => _controller?.add(_state);

  @override
  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
