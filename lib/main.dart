import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_v2/app/themes/constants/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/translations/app_translation.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  // final app = srv.GetServer(
  //   host: Platform.localHostname,
  //   port: 9000,
  //   useLog: true,
  //   getPages: [],
  // );
  // app.get('/home', () => srv.Text('Get_server of js way'));
  // app.ws('/socket', () => srv.Text('YO goki'));
  // app.start();

  runApp(GetMaterialApp(
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    themeMode: ThemeMode.system,
    title: "Fire Chat v2",
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    enableLog: true,
    initialBinding: HomeBinding(),
    locale: AppTranslationService.locale,
    fallbackLocale: AppTranslationService.fallbackLocale,
    translations: AppTranslationService(),
  ));
}
