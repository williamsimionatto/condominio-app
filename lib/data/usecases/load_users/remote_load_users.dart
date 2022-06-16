import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/load_users.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadUsers implements LoadUsers {
  final String url;
  final HttpClient httpClient;

  RemoteLoadUsers({required this.url, required this.httpClient});

  @override
  Future<List<UserEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');

      return httpResponse
          .map<UserEntity>((json) => RemoteUserModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
