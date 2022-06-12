import 'dart:async';

import '../protocols/protocols.dart';

class SignUpState {
  String? email;

  String? emailError;
  bool get isFormValid => false;
}

class StreamSignUpPresenter {
  final Validation validation;

  StreamController<SignUpState>? _controller =
      StreamController<SignUpState>.broadcast();
  final _state = SignUpState();

  Stream<String?>? get emailErrorStream =>
      _controller?.stream.map((state) => state.emailError).distinct();

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
}
