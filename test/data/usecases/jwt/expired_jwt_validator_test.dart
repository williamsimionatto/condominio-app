import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:condominioapp/data/jwt/jwt.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';

class ExpiredJWTValidator {
  final JWTClient jwtClient;

  ExpiredJWTValidator({required this.jwtClient});

  void hasExpired(String token) {
    jwtClient.hasExpired(token);
  }
}

class JWTClientSpy extends Mock implements JWTClient {}

void main() {
  late ExpiredJWTValidator sut;
  late JWTClientSpy jwtClient;
  late String token;

  void mockValidation(String token) => when(sut.hasExpired(token));

  setUp(() {
    jwtClient = JWTClientSpy();
    sut = ExpiredJWTValidator(jwtClient: jwtClient);
    token = faker.guid.guid();
    mockValidation(token);
  });

  test('Should call JWTClient whit correct value', () {
    sut.hasExpired(token);
    verify(jwtClient.hasExpired(token));
  });
}
