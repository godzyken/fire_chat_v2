import 'dart:ui' as ui;

import 'package:fire_chat_v2/app/core/translations/app_translation.dart';
import 'package:fire_chat_v2/app/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static LanguageController? get to => Get.find();
  final language = "".obs;
  final store = GetStorage();

  String? get currentLanguage => language.value;

  @override
  void onReady() async {
    setInitialLocalLanguage();
    super.onReady();
  }

  // Retrieves and Sets language based on device settings
  setInitialLocalLanguage() {
    String? _deviceLanguage = ui.window.locale.toString();
    _deviceLanguage =
        _deviceLanguage.substring(0, 2); //only get 1st 2 characters
    print(ui.window.locale.toString());
    updateLanguage(_deviceLanguage);
  }

// Gets current language stored
  RxString? get currentLanguageStore {
    language.value = store.read('language');
    return language;
  }

  // gets the language locale app is set to
  Locale? get getLocale {
    language.value = Globals.defaultLanguage;
    updateLanguage(Globals.defaultLanguage);
    // gets the default language key (from the translation language system)
    Locale? _updatedLocal = AppTranslationService.locale;

    // print('getLocale: ' + _updatedLocal.toString());
    return _updatedLocal;
  }

// updates the language stored
  Future<void>? updateLanguage(String value) async {
    language.value = value;
    await store.write('language', value);
    Get.updateLocale(getLocale!);
    update();
  }
}