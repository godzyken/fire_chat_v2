import 'package:fire_chat_v2/app/core/helpers/helpers.dart';
import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordUI extends GetView<AuthController> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
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
                  LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: controller.email.value,
                    iconPrefix: Icons.email,
                    labelText: 'email'.tr,
                    // validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    controller.email.value.text = value!,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'reset Password Button'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await controller.handlePasswordReset();
                        }
                      }),
                  FormVerticalSpace(),
                  signInLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if ((controller.email.value.text == '') ||
        (controller.email.value.text == null)) {
      return null;
    }
    return AppBar(title: Text('Reset Password'));
  }

  signInLink(BuildContext context) {
    if ((controller.email.value.text == '') ||
        (controller.email.value.text == null)) {
      return LabelButton(
        labelText: 'Send New Password'.tr,
        onPressed: () => Get.to(() => SignInUI()),
      );
    }
    return Container(width: 0, height: 0);
  }
}
