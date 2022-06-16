import 'dart:async';

import 'package:condominioapp/ui/helpers/erros/errors.dart';
import 'package:get/state_manager.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/pages.dart';

import '../protocols/protocols.dart';
import '../mixins/mixins.dart';

class LoginState {
  String? email;
  String? password;

  ValidationError? emailError;
  ValidationError? passwordError;
}

class StreamLoginPresenter
    with LoadingManager, NavigationManager, FormManager, ErrorManager
    implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);

  String? _email;
  String? _password;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  StreamLoginPresenter({
    required this.validation,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  @override
  Future<void> auth() async {
    try {
      mainError = null;
      isLoading = true;

      final account = await authentication
          .auth(AuthenticationParams(email: _email!, secret: _password!));
      await saveCurrentAccount.save(account!);

      navigateTo = '/home';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');

    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');

    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };

    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    isFormValid = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }
}
