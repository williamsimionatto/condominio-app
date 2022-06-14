import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  late CompareFieldsValidation sut;

  setUp(() {
    sut = const CompareFieldsValidation(
        field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return error if values are not equal', () {
    final formData = {
      'any_field': 'any_value',
      'other_field': 'other_value',
    };

    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    final formData = {
      'any_field': 'any_value',
      'other_field': 'any_value',
    };
    expect(sut.validate(formData), null);
  });
}
