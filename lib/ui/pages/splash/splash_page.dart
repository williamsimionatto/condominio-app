import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Condomínio Madre Paulina'),
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline2,
      ),
      body: Builder(builder: (context) {
        presenter.navigateToStream?.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page as String);
          }
        });

        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }),
    );
  }
}
