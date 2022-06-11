import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Condomínio Madre Paulina'),
      ),
      body: Builder(builder: (context) {
        presenter.navigateToStream?.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page as String);
          }
        });

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
