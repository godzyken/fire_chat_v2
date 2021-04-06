import 'package:fire_chat_v2/app/core/helpers/helpers.dart';
import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';

class SignUpUI extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final plugin = FacebookLogin(debug: true);


  Widget build(BuildContext context) {
    return Scaffold(
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
                  FormInputFieldWithIcon(
                    controller: controller.password.value,
                    iconPrefix: Icons.lock,
                    labelText: 'password'.tr,
                    // validator: Validator(Validator).password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        controller.password.value.text = value!,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'Sign Up Button'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          controller.handleSignIn(SignInType.STANDARD);
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
                        labelText: 'Google Sign In Button'.tr,
                        onPressed: () async {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          controller.handleSignIn(SignInType.GOOGLE);
                        },
                      ),
                      FacebookSignInButton(
                        labelText: 'Google Sign In Button'.tr,
                        onPressed: () async {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          controller.handleSignIn(SignInType.FACEBOOK);
                        },
                        onLongPressed: () =>
                            Get.offAll(() => LoginSelectorUi(plugin: plugin)),
                      ),
                      // TwitterSignInButton(
                      //   labelText: labels?.auth?.googleSignInButton,
                      //   onPressed: () async {
                      //     SystemChannels.textInput.invokeMethod('TextInput.hide');
                      //     controller.twitterSignIn(context);
                      //   },
                      // ),
                    ],
                  ),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: 'Sign In Button'.tr,
                    onPressed: () => Get.to(() => SignInUI()),
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
