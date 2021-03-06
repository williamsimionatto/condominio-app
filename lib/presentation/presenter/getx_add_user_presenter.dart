import 'dart:async';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:get/state_manager.dart';
import '../mixins/mixins.dart';

import 'package:condominioapp/ui/pages/pages.dart';

import '../protocols/protocols.dart';

class GetxAddUserPresenter extends GetxController
    with
        LoadingManager,
        NavigationManager,
        FormManager,
        ErrorManager,
        SuccessManager
    implements AddUserPresenter {
  final Validation validation;
  final AddAccount addAccount;

  final _nameError = Rx<UIError?>(null);
  final _emailError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);
  final _cpfError = Rx<UIError?>(null);

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;
  String? _cpf;
  String active = 'S';
  int roleId = 1;

  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;

  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;

  @override
  Stream<UIError?> get cpfErrorStream => _cpfError.stream;

  GetxAddUserPresenter({required this.validation, required this.addAccount});

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField('name');
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  @override
  void validateCpf(String cpf) {
    _cpf = cpf;
    _cpfError.value = _validateField('cpf');
    _validateForm();
  }

  @override
  Future<void> add() async {
    try {
      mainError = null;
      isLoading = true;

      final accountParams = AddAccountParams(
        name: _name!,
        email: _email!,
        password: _password!,
        passwordConfirmation: _passwordConfirmation!,
        roleId: roleId,
        cpf: _cpf!,
        active: active,
      );
      await addAccount.add(accountParams);

      navigateTo = '/users';
      success = 'Usu??rio cadastrado com sucesso!';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse:
          mainError = UIError.emailInUse;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  UIError? _validateField(String field) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation,
      'cpf': _cpf,
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

  void _validateForm() => isFormValid = _nameError.value == null &&
      _emailError.value == null &&
      _passwordError.value == null &&
      _passwordConfirmationError.value == null &&
      _cpfError.value == null &&
      _name != null &&
      _email != null &&
      _password != null &&
      _passwordConfirmation != null &&
      _cpf != null;
}
