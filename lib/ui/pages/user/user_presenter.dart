import 'package:condominioapp/ui/pages/pages.dart';

abstract class UserPresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<UserViewModel?>? get userStream;
  Stream<bool?>? get isSessionExpiredStream;
  Future<void> loadData();
}
