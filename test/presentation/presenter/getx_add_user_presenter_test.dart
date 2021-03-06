import 'package:condominioapp/domain/entities/user_entity.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/presentation/protocols/validation.dart';
import 'package:condominioapp/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/presentation/presenter/presenter.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  late AddUserPresenter sut;
  late ValidationSpy validation;
  late AddAccountSpy addAccount;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;
  late String cpf;
  late int roleId;
  late String active;
  late UserEntity account;

  setUp(() {
    email = faker.internet.email();
    name = faker.person.name();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    cpf = '129.500.550-60';
    roleId = 1;
    active = 'S';

    account = EntityFactory.makeUser();
    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    addAccount.mockAddAccount(account);
    sut = GetxAddUserPresenter(validation: validation, addAccount: addAccount);
  });

  setUpAll(() {
    registerFallbackValue(ParamsFactory.makeAddAccount());
    registerFallbackValue(EntityFactory.makeAccount());
  });

  group('E-mail', () {
    test('Shoul call Validation with correct email', () {
      final formData = {
        'name': null,
        'email': email,
        'password': null,
        'passwordConfirmation': null,
        'cpf': null,
      };
      sut.validateEmail(email);

      verify(() => validation.validate(field: 'email', input: formData))
          .called(1);
    });

    test('Should emit invalidFieldError if email is invalid', () async* {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.emailErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inv??lido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateEmail(email);
      sut.validateEmail(email);
    });

    test('Should emit requiredFieldError if email is empty', () async* {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.emailErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigat??rio')));
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
      final formData = {
        'name': name,
        'email': null,
        'password': null,
        'passwordConfirmation': null,
        'cpf': null,
      };
      sut.validateName(name);

      verify(() => validation.validate(field: 'name', input: formData))
          .called(1);
    });

    test('Should emit invalidFieldError if name is invalid', () async* {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.nameErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inv??lido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateName(name);
      sut.validateName(name);
    });

    test('Should emit requiredFieldError if name is empty', () async* {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.nameErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigat??rio')));
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
      final formData = {
        'name': null,
        'email': null,
        'password': password,
        'passwordConfirmation': null,
        'cpf': null,
      };
      sut.validatePassword(password);

      verify(() => validation.validate(field: 'password', input: formData))
          .called(1);
    });

    test('Should emit invalidFieldError if password is invalid', () async* {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inv??lido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePassword(password);
      sut.validatePassword(password);
    });

    test('Should emit requiredFieldError if password is empty', () async* {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.passwordErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigat??rio')));
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
      final formData = {
        'name': null,
        'email': null,
        'password': null,
        'passwordConfirmation': passwordConfirmation,
        'cpf': null,
      };

      sut.validatePasswordConfirmation(passwordConfirmation);

      verify(() => validation.validate(
          field: 'passwordConfirmation', input: formData)).called(1);
    });

    test(
        'Should emit invalidFieldError if passwordConfirmation confirmation is invalid',
        () async* {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.passwordConfirmationErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo inv??lido')));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePasswordConfirmation(passwordConfirmation);
      sut.validatePasswordConfirmation(passwordConfirmation);
    });

    test('Should emit requiredFieldError if passwordConfirmation is empty',
        () async* {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.passwordConfirmationErrorStream
          ?.listen(expectAsync1((error) => expect(error, 'Campo obrigat??rio')));
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
    sut.validateCpf(cpf);

    await sut.add();
    final accountParams = AddAccountParams(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      roleId: roleId,
      cpf: cpf,
      active: active,
    );
    verify(() => addAccount.add(accountParams)).called(1);
  });

  test('Should emit correct events on AddAccount success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validateCpf(cpf);

    expectLater(sut.mainErrorStream, emits(null));
    expectLater(sut.isLoadingStream, emits(true));
    expectLater(
        sut.successMessageStream, emits('Usu??rio cadastrado com sucesso!'));
    await sut.add();
  });

  test('Should emit correct events on EmailInUseError', () async* {
    addAccount.mockAddAccountError(DomainError.emailInUse);
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(
        sut.mainErrorStream, emitsInOrder([null, 'Email j?? est?? em uso']));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.add();
  });
}
