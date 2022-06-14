import 'package:test/test.dart';

import 'package:condominioapp/main/factories/factories.dart';
import 'package:condominioapp/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();

    expect(validations, [
      const RequiredFieldValidation('name'),
      const MinLengthValidation(size: 3, field: 'name'),
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
      const MinLengthValidation(size: 6, field: 'password'),
      const RequiredFieldValidation('passwordConfirmation'),
      const CompareFieldsValidation(
          field: 'passwordConfirmation', fieldToCompare: 'password')
    ]);
  });
}
