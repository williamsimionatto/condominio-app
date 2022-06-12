import 'package:condominioapp/presentation/presenter/presenter.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late StreamSignUpPresenter sut;
  late ValidationSpy validation;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field, value: 'value'));

  void mockValidaton({String? field, String? value}) {
    mockValidationCall(field ?? 'field').thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamSignUpPresenter(validation: validation);

    email = faker.internet.email();
    name = faker.person.name();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();

    mockValidaton();
  });

  group('E-mail', () {
    test('Shoul call Validation with correct email', () {
      sut.validateEmail(email);

      verify(validation.validate(field: 'email', value: email)).called(1);
    });

    test('Should emit invalidFieldError if email is invalid', () async* {
      mockValidaton(value: 'error');

      sut.emailErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inválido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateEmail(email);
      sut.validateEmail(email);
    });

    test('Should emit requiredFieldError if email is empty', () async* {
      mockValidaton(value: 'error');

      sut.emailErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigatório')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateEmail(email);
      sut.validateEmail(email);
    });

    test('Should emit null if email validation succeeds', () {
      sut.emailErrorStream?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateEmail(email);
      sut.validateEmail(email);
    });
  });

  group('Name', () {
    test('Shoul call Validation with correct name', () {
      sut.validateName(name);

      verify(validation.validate(field: 'name', value: name)).called(1);
    });

    test('Should emit invalidFieldError if name is invalid', () async* {
      mockValidaton(value: 'error');

      sut.nameErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inválido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateName(name);
      sut.validateName(name);
    });

    test('Should emit requiredFieldError if name is empty', () async* {
      mockValidaton(value: 'error');

      sut.nameErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigatório')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateName(name);
      sut.validateName(name);
    });

    test('Should emit null if name validation succeeds', () {
      sut.nameErrorStream?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateName(name);
      sut.validateName(name);
    });
  });

  group('Password', () {
    test('Shoul call Validation with correct password', () {
      sut.validatePassword(password);

      verify(validation.validate(field: 'password', value: password)).called(1);
    });

    test('Should emit invalidFieldError if password is invalid', () async* {
      mockValidaton(value: 'error');

      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inválido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePassword(password);
      sut.validatePassword(password);
    });

    test('Should emit requiredFieldError if password is empty', () async* {
      mockValidaton(value: 'error');

      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigatório')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePassword(password);
      sut.validatePassword(password);
    });

    test('Should emit null if password validation succeeds', () {
      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePassword(password);
      sut.validatePassword(password);
    });
  });

  group('Password Confirmation', () {
    test('Shoul call Validation with correct password confirmation', () {
      sut.validatePasswordConfirmation(passwordConfirmation);

      verify(validation.validate(
              field: 'passwordConfirmation', value: passwordConfirmation))
          .called(1);
    });

    test(
        'Should emit invalidFieldError if passwordConfirmation confirmation is invalid',
        () async* {
      mockValidaton(value: 'error');

      sut.passwordConfirmationErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inválido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePasswordConfirmation(passwordConfirmation);
      sut.validatePasswordConfirmation(passwordConfirmation);
    });

    test('Should emit requiredFieldError if passwordConfirmation is empty',
        () async* {
      mockValidaton(value: 'error');

      sut.passwordConfirmationErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigatório')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePasswordConfirmation(passwordConfirmation);
      sut.validatePasswordConfirmation(passwordConfirmation);
    });

    test('Should emit null if passwordConfirmation validation succeeds', () {
      sut.passwordConfirmationErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePasswordConfirmation(passwordConfirmation);
      sut.validatePasswordConfirmation(passwordConfirmation);
    });
  });
}
