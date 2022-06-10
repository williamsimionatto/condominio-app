import 'package:condominioapp/validation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

  @override
  String validate(String value) {
    return null as String;
  }
}

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
    expect(sut.validate('william@mail.com'), null);
  });
}
