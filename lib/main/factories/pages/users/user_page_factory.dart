import 'package:condominioapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:condominioapp/main/factories/pages/pages.dart';
import 'package:get/get.dart';

Widget makeUserPage() =>
    UserPage(makeGetxUserPresenter(Get.parameters['user_id']!));
