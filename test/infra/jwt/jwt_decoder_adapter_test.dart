import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';

import 'package:condominioapp/infra/jwt/jwt.dart';

void main() {
  late JwtDecoderAdapter sut;
  late String token;

  String mockExpiredToken() => faker.jwt.expired();

  setUp(() {
    sut = JwtDecoderAdapter();
    token = faker.jwt.valid();
  });

  test('Should return false when no expired token is passed', () {
    expect(sut.hasExpired(token), false);
  });

  test('Should return true when expired token is passed', () {
    expect(sut.hasExpired(mockExpiredToken()), true);
  });

  test('Should throw exception when invalid token is passed', () {
    expect(
        () => sut.hasExpired('invalid_token'), throwsA(DomainError.unexpected));
  });
}
