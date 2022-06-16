import '../../../data/usecases/load_users/load_users.dart';
import '../../../domain/usecases/usecases.dart';

import '../../factories/factories.dart';

LoadUsers makeRemoteLoadUsers() => RemoteLoadUsers(
      url: makeApiUrl('user'),
      httpClient: makeAuthorizeHttpClientDecorator(),
    );
