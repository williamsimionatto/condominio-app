import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  @override
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validate(String? value) {
    return value?.isNotEmpty == true ? null as String : 'Campo obrigatório';
  }
}

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('Test');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null as String), 'Campo obrigatório');
  });
}
