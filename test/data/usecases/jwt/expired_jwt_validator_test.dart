import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/jwt/jwt.dart';
import 'package:condominioapp/data/usecases/usecases.dart';

class JWTClientSpy extends Mock implements JWTClient {}

void main() {
  late ExpiredJWTValidator sut;
  late JWTClientSpy jwtClient;
  late String token;

  PostExpectation mockValidationCall(String token) =>
      when(sut.hasExpired(token));

  void mockTokenValidation(bool hasExpired) {
    mockValidationCall(token).thenReturn(!hasExpired);
  }

  setUp(() {
    jwtClient = JWTClientSpy();
    sut = ExpiredJWTValidator(jwtClient: jwtClient);
    token = faker.guid.guid();
    mockTokenValidation(false);
  });

  test('Should call JWTClient whit correct value', () {
    sut.hasExpired(token);
    verify(jwtClient.hasExpired(token));
  });

  test('Should return true when not expired token is passed', () {
    final result = sut.hasExpired(token);
    expect(result, true);
  });

  test('Should return false when expired token is passed', () {
    mockTokenValidation(true);
    final result = sut.hasExpired(token);
    expect(result, false);
  });
}
