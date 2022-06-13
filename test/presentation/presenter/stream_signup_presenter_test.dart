import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/presentation/presenter/presenter.dart';
import 'package:condominioapp/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AddAccountSpy extends Mock implements AddAccount {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

void main() {
  late StreamSignUpPresenter sut;
  late ValidationSpy validation;
  late AddAccountSpy addAccount;
  late SaveCurrentAccountSpy saveCurrentAccount;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;
  late String token;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field, value: 'value'));

  void mockValidaton({String? field, String? value}) {
    mockValidationCall(field ?? 'field').thenReturn(value);
  }

  PostExpectation mockAddAccountCall() =>
      when(addAccount.add(any as AddAccountParams));

  void mockAddAccount() {
    mockAddAccountCall().thenAnswer((_) async => AccountEntity(token: token));
  }

  PostExpectation mockSaveCurrentAccountCall() =>
      when(saveCurrentAccount.save(any as AccountEntity));

  void mockSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = StreamSignUpPresenter(
      validation: validation,
      addAccount: addAccount,
      saveCurrentAccount: saveCurrentAccount,
    );

    email = faker.internet.email();
    name = faker.person.name();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    token = faker.guid.guid();

    mockValidaton();
    mockAddAccount();
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
      sut.emailErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
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

  test('Should enable form button if all fields are valid', () async* {
    expect(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
    await Future.delayed(Duration.zero);
  });

  test('Should call AddAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.add();

    verify(addAccount.add(AddAccountParams(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    ))).called(1);
  });

  test('Should call SaveCurrentAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.add();

    verify(saveCurrentAccount.save(AccountEntity(token: token))).called(1);
  });

  test('should not emit after dispose', () {
    expectLater(sut.emailErrorStream, neverEmits(null));

    sut.dispose();
    sut.validateEmail(email);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async* {
    mockSaveCurrentAccountError();
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream?.listen(expectAsync1((error) => expect(
          error,
          'Algo errado aconteceu. Tente novamente em breve.',
        )));

    await sut.add();
  });
}
