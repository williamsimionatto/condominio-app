import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtDecoderAdapter {
  bool hasExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}

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
