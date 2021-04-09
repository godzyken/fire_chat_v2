import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/ui/ui.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (authController) => authController.firestoreUser.value?.uid != null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text('HomeView'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Get.toNamed('/settings');
                        }),
                  ],
                ),
                body: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 120),
                      Avatar(authController.firestoreUser.value),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FormVerticalSpace(),
                          Text(
                              'uidLabel'.tr +
                                  ': ' +
                                  authController.firestoreUser.value!.uid!,
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          Text(
                               'nameLabel'.tr +
                                  ': ' +
                                   authController.firestoreUser.value!.name!,
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          Text(
                              'emailLabel'.tr +
                                  ': ' +
                                  authController.firestoreUser.value!.email!,
                              style: TextStyle(fontSize: 16)),
                          FormVerticalSpace(),
                          // Text(
                          //     'adminUserLabel'.tr +
                          //         ': ' +
                          //         controller.admin.value.toString(),
                          //     style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
        )
    );
  }
}
