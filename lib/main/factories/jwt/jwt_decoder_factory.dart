import 'package:condominioapp/data/usecases/jwt/jwt.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/main/factories/usecases/usecases.dart';

JWTValidator makeJWTValidator() {
  return ExpiredJWTValidator(jwtClient: makeJWTClientAdapter());
}
