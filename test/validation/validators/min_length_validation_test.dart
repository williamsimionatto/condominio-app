import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/validation/validators/validators.dart';

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

  test('Should return null if value is equal than min size', () {
    expect(sut.validate(faker.randomGenerator.string(5, min: 5)),
        null as ValidationError);
  });

  test('Should return null if value is bigger than min size', () {
    expect(sut.validate(faker.randomGenerator.string(10, min: 6)),
        null as ValidationError);
  });
}
