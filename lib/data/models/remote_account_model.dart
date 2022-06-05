import '../../domain/entities/entities.dart';
import '../http/http.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({
    required this.accessToken,
  });

  factory RemoteAccountModel.fromJson(Map? json) {
    if (!json!.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }

    return RemoteAccountModel(accessToken: json['accessToken'] as String);
  }

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}
