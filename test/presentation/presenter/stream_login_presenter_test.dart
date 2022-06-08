import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Validation {
  String validate({required String field, required String value});
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({required this.validation});

  void validationEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Shoul call Validation with correct email', () {
    sut.validationEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
