
import 'package:fire_chat_v2/app/core/helpers/helpers.dart';
import 'package:fire_chat_v2/app/modules/auth/controllers/auth_controller.dart';
import 'package:fire_chat_v2/app/modules/auth/views/login.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';

class SignInUI extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final plugin = FacebookLogin(debug: true);

  Widget build(BuildContext context) {

    return Scaffold(
      body: buildForm(context),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
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
                  // labelText: labels?.auth?.emailFormField,
                  // validator: Validator(labels).email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  controller.email.value.text = value!,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: controller.password.value,
                  iconPrefix: Icons.lock,
                  // labelText: labels?.auth?.passwordFormField,
                  // validator: Validator(labels).password,
                  obscureText: true,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  controller.password.value.text = value!,
                  maxLines: 1,
                ),
                FormVerticalSpace(),
                PrimaryButton(
                    // labelText: labels?.auth?.signInButton,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
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
                      // labelText: labels?.auth?.googleSignInButton,
                      onPressed: () async {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        controller.handleSignIn(SignInType.GOOGLE);
                      },
                    ),
                    FacebookSignInButton(
                      // labelText: labels?.auth?.googleSignInButton,
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
                    //     // controller.twitterSignIn(context);
                    //   },
                    // ),
                  ],
                ),
                FormVerticalSpace(),
                LabelButton(
                  // labelText: labels?.auth?.resetPasswordLabelButton,
                  // onPressed: () => Get.to(() => ResetPasswordUI()),
                  onPressed: () => Get.to(() => null),
                ),
                LabelButton(
                  // labelText: labels?.auth?.signUpLabelButton,
                  // onPressed: () => Get.offAll(() => SignUpUI()),
                  onPressed: () => Get.offAll(() => null),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}