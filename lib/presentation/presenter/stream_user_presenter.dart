import 'dart:async';

import 'package:condominioapp/domain/helpers/helpers.dart';
import 'package:condominioapp/domain/usecases/usecases.dart';
import 'package:condominioapp/ui/pages/pages.dart';

class UserState {
  bool? isLoading = false;
  late List<UserViewModel>? users = [];
  String? mainError;
}

class StreamUsersPresenter implements UsersPresenter {
  final LoadUsers loadUsers;
  final bool? isLoading = true;

  StreamController<UserState>? _controller =
      StreamController<UserState>.broadcast();

  final _state = UserState();

  @override
  Stream<bool?>? get isLoadingStream =>
      _controller?.stream.map((state) => state.isLoading).distinct();

  @override
  Stream<List<UserViewModel>?>? get loadUsersStream =>
      _controller?.stream.map((state) => state.users).distinct();

  @override
  Stream<String?>? get mainErrorStream =>
      _controller?.stream.map((state) => state.mainError).distinct();

  StreamUsersPresenter({required this.loadUsers});

  @override
  Future<void> loadData() async {
    try {
      _state.mainError = null;
      _state.isLoading = true;
      _update();

      final users = await loadUsers.load();
      _state.users = users
          .map(
            (user) => UserViewModel(
              id: user.id,
              name: user.name,
              email: user.email,
              active: user.active,
              cpf: user.cpf,
            ),
          )
          .toList();

      _update();
    } on DomainError catch (error) {
      _state.mainError = error.description;
    } finally {
      _state.isLoading = false;
      _update();
    }
  }

  void _update() => _controller?.add(_state);

  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
