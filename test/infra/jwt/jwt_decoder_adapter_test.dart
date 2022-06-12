import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtDecoderAdapter {
  bool hasExpired(String token) {
    return JwtDecoder.isExpired(token);
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
}
