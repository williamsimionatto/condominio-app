import '../entities/entities.dart';

abstract class LoadUsers {
  Future<List<UserEntity>> load();
}
