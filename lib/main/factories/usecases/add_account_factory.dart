import 'package:condominioapp/data/usecases/usecases.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/main/factories/http/http.dart';

AddAccount makeRemoteAddAccount() => RemoteAddAccount(
    httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('user'));
