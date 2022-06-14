enum DomainError { unexpected, invalidCredentials, emailInUse, accessDenied }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'Credencias Inválidas';
      case DomainError.emailInUse:
        return 'Email já está em uso';
      case DomainError.accessDenied:
        return 'Acesso Negado';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
