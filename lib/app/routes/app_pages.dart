import 'package:get/get.dart';

import 'package:fire_chat_v2/app/modules/auth/bindings/auth_binding.dart';
import 'package:fire_chat_v2/app/modules/auth/views/auth_view.dart';
import 'package:fire_chat_v2/app/modules/cha_t_nel/bindings/cha_t_nel_binding.dart';
import 'package:fire_chat_v2/app/modules/cha_t_nel/views/cha_t_nel_view.dart';
import 'package:fire_chat_v2/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_v2/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.CHA_T_NEL,
      page: () => ChaTNelView(),
      binding: ChaTNelBinding(),
    ),
  ];
}
