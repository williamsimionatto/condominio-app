import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/load_users.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadUser implements LoadUser {
  final String url;
  final HttpClient httpClient;

  RemoteLoadUser({required this.url, required this.httpClient});

  @override
  Future<UserEntity> loadByUser({String? userId}) async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return RemoteUserModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
