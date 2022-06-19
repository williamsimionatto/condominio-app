import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:test/test.dart';
import 'package:condominioapp/validation/validators/validators.dart';

void main() {
  late CPFValidation sut;
  setUp(() {
    sut = const CPFValidation('cpf');
  });

  test('Should return null on invalid case', () {
    final formData = {};

    expect(sut.validate(formData), null);
  });

  test('Should return null if cpf is empty', () {
    final formData = {
      'cpf': '',
    };

    expect(sut.validate(formData), null);
  });

  test('Should return null if cpf is null', () {
    final formData = {
      'cpf': null,
    };
    expect(sut.validate(formData), null);
  });

  test('Should return null if formatted cpf is valid', () {
    final formData = {'cpf': '123.456.789-00'};

    expect(sut.validate(formData), null);
  });

  test('Should return null if unformatted cpf is valid', () {
    final formData = {'cpf': '12345678900'};

    expect(sut.validate(formData), null);
  });

  test('Should return error if cpf is invalid', () {
    final formData = {
      'cpf': '123.456.789',
    };

    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return error if unformatted cpf is invalid', () {
    final formData = {
      'cpf': '123456789',
    };

    expect(sut.validate(formData), ValidationError.invalidField);
  });
}
