import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../ui/components/components.dart';

import '../../ui/pages/pages.dart';
import 'factories/factories.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final routeObserserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());

    return GetMaterialApp(
      title: 'Madre Paulina',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      navigatorObservers: [routeObserserver],
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(
            name: '/home',
            page: () => const HomePage(),
            transition: Transition.fadeIn),
        GetPage(
          name: '/login',
          page: makeLoginPage,
          transition: Transition.fadeIn,
        ),
        GetPage(name: '/users', page: makeUsersPage),
        GetPage(name: '/users/add', page: makeSignUpPage)
      ],
    );
  }
}
