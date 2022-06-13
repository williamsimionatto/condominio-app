enum DomainError { unexpected, invalidCredentials, emailInUse }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'Credencias Inválidas';
      case DomainError.emailInUse:
        return 'Email já está em uso';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
