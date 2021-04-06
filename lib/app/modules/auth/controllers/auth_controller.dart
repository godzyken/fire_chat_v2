import 'package:fire_chat_v2/app/core/helpers/helpers.dart';
import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/data/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as mat;
import 'package:get/get.dart';


class  AuthController extends GetxController {
  static AuthController to = Get.find();

  final email = mat.TextEditingController().obs;
  final name = mat.TextEditingController().obs;
  final password = mat.TextEditingController().obs;
  RxBool isLogged = false.obs;
  final user = Rxn<User>();
  final firestoreUser = Rxn<UserModel>();
  late AuthService _authService;

  AuthController() {
    _authService = AuthService();
  }

  @override
  void onInit() async {
    ever(isLogged, handleAuthChanged);
    user.value = await _authService.getCurrentUser();
    isLogged.value = user.value != null;
    _authService.onAuthChanged().listen((event) {
      isLogged.value = event != null;
      user.value = event;
    });

    super.onInit();
  }

  handleAuthChanged(isLoggedIn) {
    if (isLoggedIn == false) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/home");
    }
  }

  handleSignIn(SignInType type) async {
    if (type == SignInType.STANDARD) {
      if (email.value.text.trim() == "" || password.value.text.trim() == "") {
        Get.snackbar("Error", "Empty email or password");
        return;
      }
    }

    Get.snackbar("Signing In", "Loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(minutes: 2));
    try {
      if (type == SignInType.STANDARD) {
        await _authService.signInWithEmailAndPassword(
            email.value.text.trim(), password.value.text.trim()
        );
        if (type == SignInType.GOOGLE) {
          await _authService.googleSignIn();
        }
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          actions: [
            mat.TextButton(
                onPressed: () {
                  Get.back();
                },
                child: mat.Text("close"),
            ),
          ]
      );
      print(e);
    }
  }

  handleSignUp() async {
    if (email.value.text.trim() == "" || password.value.text.trim() == "") {
      Get.snackbar("Error", "Empty email or password");
      return;
    }

    Get.snackbar("Signing up", "Loading",
      showProgressIndicator: true,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(minutes: 2)
    );
    try {
      await _authService.signUp(
          email.value.text.trim(),
          password.value.text.trim());
    } catch (e) {
      Get.back();
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
        actions: [
          mat.TextButton(
              onPressed: () {
                Get.back();
              },
              child: mat.Text("Close")),
        ]
      );
      print(e);
    }
  }

  handlePasswordReset() async {
    if (email.value.text.trim() == "" || password.value.text.trim() == "") {
      Get.snackbar("Error", "Empty email or password");
      return;
    }

    Get.snackbar("Change password", "Loading",
    showProgressIndicator: true,
    snackPosition: SnackPosition.BOTTOM,
    duration: Duration(minutes: 2)
    );
    try {
      await _authService.sendPasswordResetMail(
          email.value.text.trim(),
      );
    } catch (e) {
      Get.back();
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          actions: [
            mat.TextButton(
                onPressed: () {
                  Get.back();
                },
                child: mat.Text("Close")),
          ]
      );
    }

  }

  handleSignOut() {
    _authService.signOut();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    email.close();
    password.close();
    super.onClose();
  }


}
