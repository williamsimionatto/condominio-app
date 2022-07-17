import 'package:condominioapp/ui/pages/pages.dart';

class ViewModelFactory {
  static UserViewModel makeUser() => const UserViewModel(
        id: 1,
        name: 'Teste',
        email: 'teste@mail.com',
        active: 'S',
        cpf: "123456789",
        roleId: 1,
      );

  static List<UserViewModel> makeUserList() => [
        const UserViewModel(
          id: 1,
          name: 'Usuário 1',
          email: 'usuario1@mail.com',
          active: 'S',
          cpf: "123456789",
          roleId: 1,
        ),
        const UserViewModel(
          id: 2,
          name: 'Usuário 2',
          email: 'usuario@2mail.com',
          active: 'N',
          cpf: "123456789",
          roleId: 1,
        ),
      ];
}
