import 'package:fire_chat_v2/app/core/translations/selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppTranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys =>
      {'pt_BR': ptBR, 'en_US': enUs, 'es_MX': esMx, 'fr_FR': frFR};
}
