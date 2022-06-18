abstract class UserPresenter {
  Stream<bool?>? get isLoadingStream;

  Future<void> loadData();
}
