import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/components.dart';

import 'package:condominioapp/ui/pages/pages.dart';
import 'package:condominioapp/ui/mixins/mixins.dart';

class SignUpPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UIErrorManager, NavigationManager {
  final SignUpPresenter presenter;

  SignUpPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Usuários"),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline2,
      ),
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        handleMainError(context, presenter.mainErrorStream);
        handleNavigation(presenter.navigateToStream, clear: false);

        return GestureDetector(
          onTap: () => hideKeyboard(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(38),
                  child: ListenableProvider(
                    create: (_) => presenter,
                    child: Form(
                      child: Column(
                        children: const <Widget>[
                          NameInput(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: EmailInput(),
                          ),
                          PasswordInput(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: PasswordConfirmationInput(),
                          ),
                          Center(
                            child: SignUpButton(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
