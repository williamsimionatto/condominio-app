import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:test/test.dart';

import 'package:condominioapp/validation/validators/validators.dart';

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = const RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final formData = {'any_field': 'any_value'};

    expect(sut.validate(formData), null);
  });

  test('Should return error if value is empty', () {
    final formData = {'any_field': ''};
    expect(sut.validate(formData), ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    final formData = {'any_field': null};
    expect(sut.validate(formData), ValidationError.requiredField);
  });
}
