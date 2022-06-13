import '../../../../presentation/protocols/validation.dart';
import '../../../../validation/validators/validators.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../builders/validation_builder.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().min(3).build()
  ];
}
