import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/jwt/jwt.dart';

class ExpiredJWTValidator {
  final JWTClient jwtClient;

  ExpiredJWTValidator({required this.jwtClient});

  bool hasExpired(String token) {
    return jwtClient.hasExpired(token);
  }
}

class JWTClientSpy extends Mock implements JWTClient {}

void main() {
  late ExpiredJWTValidator sut;
  late JWTClientSpy jwtClient;
  late String token;

  PostExpectation mockValidationCall(String token) =>
      when(sut.hasExpired(token));

  void mockValidToken(String token) {
    mockValidationCall(token).thenReturn(true);
  }

  setUp(() {
    jwtClient = JWTClientSpy();
    sut = ExpiredJWTValidator(jwtClient: jwtClient);
    token = faker.guid.guid();
    mockValidToken(token);
  });

  test('Should call JWTClient whit correct value', () {
    sut.hasExpired(token);
    verify(jwtClient.hasExpired(token));
  });

  test('Should return true when not expired token is passed', () {
    final result = sut.hasExpired(token);
    expect(result, true);
  });
}
