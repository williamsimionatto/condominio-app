import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/protocols/protocols.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({required String field, required String value}) {
    return null as String;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  late ValidationComposite sut;

  // setUp(() {
  //   sut = ValidationComposite([]);
  // });

  test('Should return null if all validations returns null or empty', () {
    final validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate('any_value')).thenReturn(null as String);

    final validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate('any_value')).thenReturn('');
    sut = ValidationComposite([validation1, validation2]);

    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, null as String);
  });
}
