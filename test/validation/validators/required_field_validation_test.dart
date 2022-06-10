import 'package:test/test.dart';

import 'package:condominioapp/validation/validators/validators.dart';

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('Test');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), '');
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null as String), 'Campo obrigatório');
  });
}
