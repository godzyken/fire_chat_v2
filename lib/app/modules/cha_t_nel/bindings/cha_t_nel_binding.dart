import 'package:get/get.dart';

import '../controllers/cha_t_nel_controller.dart';

class ChaTNelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChaTNelController>(
      () => ChaTNelController(),
    );
  }
}
