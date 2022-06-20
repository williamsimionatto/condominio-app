import 'package:flutter/material.dart';

import '../components/components.dart';

mixin SuccessManager {
  void handleSuccessMessage(BuildContext context, Stream<String?>? stream) {
    stream?.listen((message) {
      if (message != null) {
        showSuccessMessage(context, message);
      }
    });
  }
}
