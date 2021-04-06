

import 'package:fire_chat_v2/app/core/helpers/helpers.dart';
import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/modules/auth/views/reset_password_ui.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UpdateProfileUI extends GetView<AuthController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {

    //print('user.name: ' + user?.value?.name);
    controller.name.value.text =
        controller.user.value!.displayName!;
    controller.email.value.text =
        controller.user.value!.email!;
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile'.tr)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Avatar(controller.firestoreUser.value),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: controller.name.value,
                    iconPrefix: Icons.person,
                    labelText: 'name'.tr,
                    // validator: Validator(Validator).name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    controller.name.value.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: controller.email.value,
                    iconPrefix: Icons.email,
                    labelText: 'email'.tr,
                    // validator: Validator(Validator).email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    controller.email.value.text = value!,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'Update User'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              uid: controller.user.value?.uid,
                              name: controller.name.value.text,
                              email: controller.email.value.text,
                              photoUrl: controller.user.value?.photoURL);
                          _updateUserConfirm(context, _updatedUser,
                              controller.user.value?.email);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'reset Password Button'.tr,
                    onPressed: () => Get.to(() => ResetPasswordUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String? oldEmail) async {
    final TextEditingController _password = new TextEditingController();
    return Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      title: Text(
        'Enter Password'.tr,
      ),
      content: FormInputFieldWithIcon(
        controller: _password,
        iconPrefix: Icons.lock,
        labelText: 'Password'.tr,
        // validator: Validator(Validator).password,
        obscureText: true,
        onChanged: (value) => null,
        onSaved: (value) => _password.text = value!,
        maxLines: 1,
      ),
      actions: <Widget>[
        new TextButton(
          child: new Text('cancel'.toUpperCase().tr),
          onPressed: () {
            Get.back();
          },
        ),
        new TextButton(
          child: new Text('submit'.toUpperCase().tr),
          onPressed: () async {
            Get.back();
            // await controller.updateUser(
            //     context, updatedUser, oldEmail, _password.text);
          },
        )
      ],
    ));
  }
}
