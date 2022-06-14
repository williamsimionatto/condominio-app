import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:test/test.dart';
import 'package:condominioapp/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;
  setUp(() {
    sut = const EmailValidation('email');
  });

  test('Should return null on invalid case', () {
    final formData = {};

    expect(sut.validate(formData), null);
  });

  test('Should return null if email is empty', () {
    final formData = {
      'email': '',
    };

    expect(sut.validate(formData), null);
  });

  test('Should return null if email is null', () {
    final formData = {
      'email': null,
    };
    expect(sut.validate(formData), null);
  });

  test('Should return null if email is valid', () {
    final formData = {'email': 'william.simionatto@mail.com'};

    expect(sut.validate(formData), null);
  });

  test('Should return error if email is invalid', () {
    final formData = {
      'email': 'william.simionatto',
    };

    expect(sut.validate(formData), ValidationError.invalidField);
  });
}
