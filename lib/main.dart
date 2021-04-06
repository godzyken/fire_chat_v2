import 'dart:io';

import 'package:fire_chat_v2/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_v2/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:get_server/get_server.dart' as srv;
import 'package:get_storage/get_storage.dart';

import 'app/core/translations/app_translation.dart';
import 'app/routes/app_pages.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  final app = srv.GetServer(
    host: Platform.localHostname,
    port: 9000,
    useLog: true,
    getPages: [],

  );
  app.get('/home', () => srv.Text('Get_server of js way'));
  app.ws('/socket', () => srv.Text('YO goki'));
  app.start();

  runApp(
    GetMaterialApp(
      title: "Fire Chat v2",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      enableLog: true,
      initialBinding: HomeBinding(),
      locale: AppTranslationService.locale,
      fallbackLocale:AppTranslationService.fallbackLocale,
      translations: AppTranslationService(),
      home: HomeView(),
    ),
  );
}
