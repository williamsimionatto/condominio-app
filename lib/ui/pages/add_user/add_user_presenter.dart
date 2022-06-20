import 'package:condominioapp/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';

abstract class AddUserPresenter implements Listenable {
  Stream<UIError?>? get nameErrorStream;
  Stream<UIError?>? get emailErrorStream;
  Stream<UIError?>? get passwordErrorStream;
  Stream<UIError?>? get passwordConfirmationErrorStream;
  Stream<UIError?>? get cpfErrorStream;
  Stream<UIError?>? get mainErrorStream;

  Stream<bool?>? get isFormValidStream;
  Stream<bool?>? get isLoadingStream;
  Stream<String?>? get navigateToStream;
  Stream<String?>? get successMessageStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);
  void validateCpf(String cpf);

  Future<void> add();
}
