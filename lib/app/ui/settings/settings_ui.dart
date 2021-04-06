
import 'package:fire_chat_v2/app/core/controllers/language_controller.dart';
import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/themes/themes.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsUI extends GetView<AuthController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {

    return ListView(
      children: <Widget>[
        languageListTile(context),
        themeListTile(context),
        ListTile(
            title: Text('Update Profile'.tr),
            trailing: ElevatedButton(
              onPressed: () async {
                Get.to(() => UpdateProfileUI());
              },
              child: Text(
                'Update Profile'.tr,
              ),
            )),
        ListTile(
          title: Text('signOut'.tr),
          trailing: ElevatedButton(
            onPressed: () {
              controller.handleSignOut();
            },
            child: Text(
              'signOut'.tr,
            ),
          ),
        )
      ],
    );
  }

  languageListTile(BuildContext context) {
    return GetBuilder<
        LanguageController>(
      builder: (controller) => ListTile(
        title: Text('language'.tr),
        trailing: DropdownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value!);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system",
          value: 'system'.tr,
          icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light",
          value: 'settings light'.tr,
          icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: 'settings dark'.tr, icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text('theme'.tr),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
