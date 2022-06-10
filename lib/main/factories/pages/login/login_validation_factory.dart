import '../../../../presentation/protocols/validation.dart';
import '../../../../validation/validators/validators.dart';
import '../../../../validation/protocols/protocols.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    const RequiredFieldValidation('email'),
    const EmailValidation('email'),
    const RequiredFieldValidation('password'),
  ];
}
