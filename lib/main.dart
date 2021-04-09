import 'dart:io';

import 'package:fire_chat_v2/app/core/controllers/language_controller.dart';
import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_v2/app/modules/home/controllers/home_controller.dart';
import 'package:fire_chat_v2/app/modules/home/views/home_view.dart';
import 'package:fire_chat_v2/app/themes/constants/app_themes.dart';
import 'package:fire_chat_v2/app/themes/controller/theme_controller.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as srv;
import 'package:get_storage/get_storage.dart';

import 'app/core/translations/app_translation.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {

    Get.put<ThemeController>(ThemeController());
    Get.put<LanguageController>(LanguageController());
    Get.put<HomeController>(HomeController());

    await GetStorage.init();

  } catch (e, stacktrace) {
    print(stacktrace);
  }

  final app = srv.GetServer(
    host: Platform.localHostname,
    port: 9000,
    useLog: true,
    getPages: [],
  );
  app.get('/home', () => srv.Text('Get_server of js way'));
  app.ws('/socket', () => srv.Text('YO goki'));
  app.start();

  runApp(FireChatApp());
}

class FireChatApp extends StatefulWidget {
  @override
  _FireChatAppState createState() => _FireChatAppState();
}

class _FireChatAppState extends State<FireChatApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        builder: (languageController) => Loading(
          child: GetMaterialApp(
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.system,
            title: "Fire Chat v2",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            enableLog: true,
            initialBinding: HomeBinding(),
            locale: AppTranslationService.locale,
            fallbackLocale:AppTranslationService.fallbackLocale,
            translations: AppTranslationService(),
          ),
        ),
    );
  }
}
