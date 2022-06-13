import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/validation/protocols/protocols.dart';
import 'package:condominioapp/validation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  late ValidationComposite sut;
  late FieldValidationSpy validation1;
  late FieldValidationSpy validation2;
  late FieldValidationSpy validation3;

  void mockValidation1(ValidationError error) {
    when(validation1.validate('any_value')).thenReturn(error);
  }

  void mockValidation2(ValidationError error) {
    when(validation2.validate('any_value')).thenReturn(error);
  }

  void mockValidation3(ValidationError error) {
    when(validation3.validate('any_value')).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null as ValidationError);

    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null as ValidationError);

    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null as ValidationError);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    // mockValidation2(ValidationError.requiredField);
    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, null);
  });

  test('Should return the first error', () {
    mockValidation1(ValidationError.invalidField);
    mockValidation2(ValidationError.requiredField);
    mockValidation3(ValidationError.invalidField);

    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, ValidationError.requiredField);
  });
}
