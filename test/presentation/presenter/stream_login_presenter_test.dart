import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';
import 'package:condominioapp/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field, value: 'value'));

  void mockValidaton({String? field, String? value}) {
    mockValidationCall(field ?? 'field').thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidaton();
  });

  test('Shoul call Validation with correct email', () {
    sut.validationEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () async* {
    mockValidaton(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.validationEmail(email);
    sut.validationEmail(email);
  });
}
