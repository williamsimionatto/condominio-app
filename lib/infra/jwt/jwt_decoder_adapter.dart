import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:condominioapp/domain/helpers/helpers.dart';

class JwtDecoderAdapter {
  bool hasExpired(String token) {
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
