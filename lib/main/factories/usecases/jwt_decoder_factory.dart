import 'package:condominioapp/data/jwt/jwt_client.dart';
import 'package:condominioapp/infra/jwt/jwt_decoder_adapter.dart';

JWTClient makeJWTClientAdapter() {
  return JwtDecoderAdapter();
}
