import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/modules/cha_t_nel/bindings/cha_t_nel_binding.dart';
import 'package:fire_chat_v2/app/modules/cha_t_nel/views/cha_t_nel_view.dart';
import 'package:fire_chat_v2/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_v2/app/modules/home/views/home_view.dart';
import 'package:fire_chat_v2/app/ui/ui.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    // GetPage(name: '/notfound', page: () => UnknownRoutePage()),
    GetPage(name: _Paths.SPLASH, page: () => SplashUi()),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // Root for Auth, login, signIn, signUp, resetPassword
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(name: _Paths.LOGIN, page: () => SignInUI(), binding: AuthBinding()),
    GetPage(
        name: _Paths.CREATE_ACCOUNT,
        page: () => SignInUI(),
        binding: AuthBinding()),
    GetPage(
        name: _Paths.RESET_PASSWORD,
        page: () => ResetPasswordUI(),
        binding: AuthBinding()),
    // Root for webSocket & ChatApi
    GetPage(
      name: _Paths.CHA_T_NEL,
      page: () => ChaTNelView(),
      binding: ChaTNelBinding(),
    ),

    // Root for settings
    GetPage(name: _Paths.SETTINGS, page: () => SettingsUI())
  ];
}
