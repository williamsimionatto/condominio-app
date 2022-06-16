enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo obrigatório';
      case UIError.invalidField:
        return 'Campo inválido';
      case UIError.invalidCredentials:
        return 'Credenciais inválidas.';
      case UIError.emailInUse:
        return 'O email já está em uso.';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
