import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  late CompareFieldsValidation sut;

  setUp(() {
    sut = const CompareFieldsValidation(
        field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equal', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });

  test('Should return null if values are equal', () {
    expect(sut.validate('any_value'), null);
  });
}
