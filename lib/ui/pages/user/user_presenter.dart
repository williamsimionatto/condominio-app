import 'package:condominioapp/ui/pages/pages.dart';

abstract class UserPresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<UserViewModel?>? get userStream;
  Future<void> loadData();
}
