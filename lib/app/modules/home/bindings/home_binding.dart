import 'package:fire_chat_v2/app/themes/controller/theme_controller.dart';
import 'package:get/get.dart';

import '../../../core/controllers/language_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
