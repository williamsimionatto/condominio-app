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

void main() {
  late StreamLoginPresenter sut;
  late AuthenticationSpy authentication;
  late ValidationSpy validation;
  late String email;
  late String password;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field, value: 'value'));

  void mockValidaton({String? field, String? value}) {
    mockValidationCall(field ?? 'field').thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication
      .auth(AuthenticationParams(email: email, secret: password)));

  void mockAuthetication() {
    mockAuthenticationCall()
        .thenAnswer((_) async => AccountEntity(token: faker.guid.guid()));
  }

  void mockAutheticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidaton();
    mockAuthetication();
  });

  test('Shoul call Validation with correct email', () {
    sut.validationEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () async* {
    mockValidaton(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationEmail(email);
    sut.validationEmail(email);
  });

  test('Should emit null if email validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationEmail(email);
    sut.validationEmail(email);
  });

  test('Shoul call Validation with correct password', () {
    sut.validationPassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () async* {
    mockValidaton(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationPassword(password);
    sut.validationPassword(password);
  });

  test('Should emit null if password validation succeeds', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationPassword(password);
    sut.validationPassword(password);
  });

  test('Should emit error if any field is invalid', () async* {
    mockValidaton(field: 'each', value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validationEmail(email);
    sut.validationPassword(password);
  });

  test('Should emit form valid event if form is valid', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    expect(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validationEmail(email);
    await Future.delayed(Duration.zero);
    sut.validationPassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validationEmail(email);
    sut.validationPassword(password);

    await sut.auth();

    verify(authentication
            .auth(AuthenticationParams(email: email, secret: password)))
        .called(1);
  });

  test('Should emit correct events on Authentication success', () async {
    sut.validationEmail(email);
    sut.validationPassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialsError', () async {
    mockAutheticationError(DomainError.invalidCredentials);

    sut.validationEmail(email);
    sut.validationPassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, 'Credencias Inválidas')));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAutheticationError(DomainError.unexpected);

    sut.validationEmail(email);
    sut.validationPassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) =>
        expect(error, 'Algo errado aconteceu. Tente novamente em breve.')));

    await sut.auth();
  });
}
