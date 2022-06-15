import '../../../data/usecases/load_users/load_users.dart';

import '../../../domain/usecases/usecases.dart';

import '../../../main/factories/http/http.dart';

LoadUsers makeRemoteLoadUsers() =>
    RemoteLoadUsers(url: makeApiUrl('user'), httpClient: makeHttpAdapter());
