import '../../../data/jwt/jwt_client.dart';
import '../../../domain/usecases/usecases.dart';

class ExpiredJWTValidator implements JWTValidator {
  final JWTClient jwtClient;

  ExpiredJWTValidator({required this.jwtClient});

  @override
  bool hasExpired(String token) {
    return jwtClient.hasExpired(token);
  }
}
