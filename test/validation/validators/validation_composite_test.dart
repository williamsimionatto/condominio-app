import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/protocols/protocols.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({required String field, required String value}) {
    String error = null as String;

    for (final validation in validations) {
      error = validation.validate(value);

      if (error?.isNotEmpty ?? true) {
        return error;
      }
    }

    return error;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  late ValidationComposite sut;
  late FieldValidationSpy validation1;
  late FieldValidationSpy validation2;
  late FieldValidationSpy validation3;

  void mockValidation1(String error) {
    when(validation1.validate('any_value')).thenReturn(error);
  }

  void mockValidation2(String error) {
    when(validation2.validate('any_value')).thenReturn(error);
  }

  void mockValidation3(String error) {
    when(validation3.validate('any_value')).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('any_field');
    mockValidation1(null as String);

    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null as String);

    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('other_field');
    mockValidation3(null as String);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    mockValidation2('');
    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, null as String);
  });

  test('Should return the first error', () {
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, 'error_1');
  });
}
