import 'package:condominioapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';

import '../../factories.dart';

Widget makeSplashPage() {
  return SplashPage(presenter: makeSplashPresenter());
}
