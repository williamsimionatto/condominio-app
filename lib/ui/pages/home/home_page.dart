import 'package:condominioapp/ui/components/components.dart';
import 'package:flutter/material.dart';
import '../../../ui/pages/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColorsDark.backgroundColor,
      drawer: NavBar(),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
