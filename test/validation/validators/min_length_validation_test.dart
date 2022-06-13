import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:condominioapp/validation/protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  final int size;
  @override
  final String field;

  MinLengthValidation({required this.size, required this.field});

  @override
  ValidationError validate(String value) {
    return ValidationError.invalidField;
  }
}

void main() {
  late MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(size: 5, field: 'any_field');
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(null as String), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null as String), ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    expect(sut.validate(faker.randomGenerator.string(4, min: 1)),
        ValidationError.invalidField);
  });
}
