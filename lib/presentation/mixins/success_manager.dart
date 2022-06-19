import 'package:get/get.dart';

mixin SuccessManager on GetxController {
  final _successMessage = Rx<String?>(null);
  Stream<String?> get successMessageStream => _successMessage.stream;
  set success(String? value) => _successMessage.value = value;
}
