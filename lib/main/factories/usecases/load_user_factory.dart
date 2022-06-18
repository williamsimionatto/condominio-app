import 'package:condominioapp/data/usecases/load_users/remote_load_user.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/main/factories/http/api_url_factory.dart';
import 'package:condominioapp/main/factories/http/authorize_http_client_decorator__factory.dart';

LoadUser makeRemoteLoadUser(String userId) => RemoteLoadUser(
      url: makeApiUrl('user/$userId'),
      httpClient: makeAuthorizeHttpClientDecorator(),
    );
