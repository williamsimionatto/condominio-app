abstract class Validation {
  ValidationError? validate({required String field, required Map input});
}

enum ValidationError {
  requiredField,
  invalidField,
}

extension ValidationErrorExtension on ValidationError {
  String get description {
    switch (this) {
      case ValidationError.requiredField:
        return 'Campo obrigatório';
      case ValidationError.invalidField:
        return 'Campo inválido';
    }
  }
}
