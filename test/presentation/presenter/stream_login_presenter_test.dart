import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/domain/entities/entities.dart';
import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

import 'package:condominioapp/presentation/presenter/presenter.dart';
import 'package:condominioapp/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

void main() {
  late StreamLoginPresenter sut;
  late AuthenticationSpy authentication;
  late ValidationSpy validation;
  late SaveCurrentAccountSpy saveCurrentAccount;
  late String email;
  late String password;
  late String token;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field, input: anyNamed('input') as Map));

  void mockValidaton({String? field, String? value}) {
    mockValidationCall(field ?? 'field').thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication
      .auth(AuthenticationParams(email: email, secret: password)));

  void mockAuthetication() {
    mockAuthenticationCall()
        .thenAnswer((_) async => AccountEntity(token: token));
  }

  void mockAutheticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  PostExpectation mockSaveCurrentAccountCall() =>
      when(saveCurrentAccount.save(any as AccountEntity));

  void mockSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = StreamLoginPresenter(
      validation: validation,
      authentication: authentication,
      saveCurrentAccount: saveCurrentAccount,
    );

    email = faker.internet.email();
    password = faker.internet.password();
    token = faker.guid.guid();

    mockValidaton();
    mockAuthetication();
  });

  test('Shoul call Validation with correct email', () {
    sut.validateEmail(email);
    final formData = {'email': email, 'password': null};

    verify(validation.validate(field: 'email', input: formData)).called(1);
  });

  test('Should emit email error if validation fails', () async* {
    mockValidaton(value: 'error');

    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, 'error')));
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

  test('Shoul call Validation with correct password', () {
    sut.validatePassword(password);
    final formData = {'email': null, 'password': password};

    verify(validation.validate(field: 'password', input: formData)).called(1);
  });

  test('Should emit password error if validation fails', () async* {
    mockValidaton(value: 'error');

    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, 'error')));
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

  test('Should emit error if any field is invalid', () async* {
    mockValidaton(field: 'each', value: 'error');

    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit form valid event if form is valid', () async* {
    sut.emailErrorStream?.listen(expectAsync1((error) => expect(error, '')));
    sut.passwordErrorStream?.listen(expectAsync1((error) => expect(error, '')));

    expect(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(authentication
            .auth(AuthenticationParams(email: email, secret: password)))
        .called(1);
  });

  test('Should call SaveCurrentAccount with correct value', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();

    verify(saveCurrentAccount.save(AccountEntity(token: token))).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async* {
    mockSaveCurrentAccountError();

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(
        sut.mainErrorStream,
        emitsInOrder(
            [null, 'Algo errado aconteceu. Tente novamente em breve.']));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.mainErrorStream, emits(null));
    expectLater(sut.isLoadingStream, emits(true));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockAutheticationError(DomainError.invalidCredentials);

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream?.listen(
        expectAsync1((error) => expect(error, 'Credencias Inválidas')));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAutheticationError(DomainError.unexpected);

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream?.listen(expectAsync1((error) =>
        expect(error, 'Algo errado aconteceu. Tente novamente em breve.')));

    await sut.auth();
  });

  test('should not emit after dispose', () {
    expectLater(sut.emailErrorStream, neverEmits(null));

    sut.dispose();
    sut.validateEmail(email);
  });

  test('Should change page on success', () async* {
    sut.validateEmail(email);
    sut.validatePassword(password);

    sut.navigateToStream?.listen(expectAsync1((page) => expect(page, '/home')));

    await sut.auth();
  });
}
