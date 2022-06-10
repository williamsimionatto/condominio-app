import 'package:test/test.dart';
import 'package:condominioapp/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;
  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null as String), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('william.simionatto@mail.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('william.simionatto'), 'Campo inválido');
  });
}
