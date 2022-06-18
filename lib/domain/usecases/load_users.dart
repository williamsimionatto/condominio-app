import '../entities/entities.dart';

abstract class LoadUsers {
  Future<List<UserEntity>> load();
}

abstract class LoadUser {
  Future<UserEntity> loadByUser(int userId);
}
