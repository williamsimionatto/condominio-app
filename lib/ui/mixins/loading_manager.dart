import '../components/components.dart';

import 'package:flutter/material.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool?>? stream) {
    stream?.listen((isLoading) async {
      isLoading == true ? await showLoading(context) : hideLoading(context);
    });
  }
}
