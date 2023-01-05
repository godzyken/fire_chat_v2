import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/modules/auth/controllers/auth_controller.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/helpers/helpers.dart';
import '../../../themes/constants/constants.dart';

class SignInUI extends GetView<AuthController> {
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Form(
        autovalidateMode: _.autovalidateMode,
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
                    controller: _.email.value,
                    iconPrefix: Icons.email_sharp,
                    onValidator: (value) =>
                        Validator(_.email.value.text).email(value!),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => {
                      _.checkEmailAlreadyExist(value),
                    },
                    onSaved: (value) => {_.email.value.text = value!},
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: _.password.value,
                    iconPrefix: Icons.password,
                    // labelText: labels?.auth?.passwordFormField,
                    // validator: Validator(labels).password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) => _.password.value.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                    labelText: 'sign in'.tr,
                    onPressed: () => _.validateInputs(),
                  ),
                  FormVerticalSpace(),
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    runSpacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      SocialConnectionIconButton(
                        labelText: 'google sign in button'.tr,
                        onPressed: () async {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        img: Image.asset(
                          Images.logoGoogle,
                          height: 60.0,
                        ),
                      ),
                      SocialConnectionIconButton(
                        labelText: 'facebook sign in button'.tr,
                        onPressed: () async {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        img: Image.asset(
                          Images.logoFacebook,
                          height: 75.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SocialConnectionIconButton(
                        labelText: 'twitter sign in button'.tr,
                        onPressed: () async {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        img: Image.asset(
                          Images.logoTwitter,
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'reset password'.tr,
                    onPressed: () => Get.toNamed('/reset-password'),
                  ),
                  _.isAlreadySignIn.isTrue
                      ? const SizedBox()
                      : LabelButton(
                          labelText: 'Create an account'.tr,
                          onPressed: () => Get.toNamed('/create-a-account'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
