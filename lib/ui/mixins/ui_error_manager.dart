import 'package:flutter/material.dart';

import '../components/components.dart';
import '../helpers/helpers.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UIError?>? stream) {
    stream?.listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
