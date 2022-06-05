import '../../domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel({
    required this.accessToken,
  });

  factory RemoteAccountModel.fromJson(Map? json) =>
      RemoteAccountModel(accessToken: json?['accessToken'] as String);

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}
