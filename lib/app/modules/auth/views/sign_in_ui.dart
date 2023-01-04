import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/modules/auth/controllers/auth_controller.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignInUI extends GetView<AuthController> {
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (_) => Form(
        key: _.signInFormKey,
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
                    iconPrefix: Icons.email,
                    // labelText: labels?.auth?.emailFormField,
                    // validator: Validator(labels).email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => _.checkEmailAlreadyExist(value),
                    onSaved: (value) => _.email.value.text = value!,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: _.password.value,
                    iconPrefix: Icons.lock,
                    // labelText: labels?.auth?.passwordFormField,
                    // validator: Validator(labels).password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) => _.password.value.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'signIn'.tr,
                      onPressed: () async {
                        if (_.signInFormKey.currentState!.validate()) {
                          _.isAlreadySignIn.isTrue
                              ? _.login(
                                  _.email.value.text, _.password.value.text)
                              : _.register(
                                  _.email.value.text, _.password.value.text);
                        }
                      }),
                  FormVerticalSpace(),
                  Wrap(
                    runAlignment: WrapAlignment.center,
                    runSpacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      GoogleSignInButton(
                        labelText: 'googleSignInButton'.tr,
                        onPressed: () async {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          // _.googleSignIn(context);
                        },
                      ),
                      FacebookSignInButton(
                        labelText: 'googleSignInButton'.tr,
                        onPressed: () async {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        onLongPressed: () => {},
                      ),
                      // TwitterSignInButton(
                      //   labelText: labels?.auth?.googleSignInButton,
                      //   onPressed: () async {
                      //     SystemChannels.textInput.invokeMethod('TextInput.hide');
                      //     // _.twitterSignIn(context);
                      //   },
                      // ),
                    ],
                  ),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'resetPassword'.tr,
                    onPressed: () => Get.toNamed('/reset-password'),
                  ),
                  _.isAlreadySignIn.isTrue
                      ? const SizedBox()
                      : LabelButton(
                          labelText: 'Create'.tr,
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
