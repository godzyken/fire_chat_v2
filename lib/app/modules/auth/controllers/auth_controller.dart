import 'dart:developer';

import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/modules/cha_t_nel/cha_t_nel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/sign_in_ui.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final email = TextEditingController().obs;
  final name = TextEditingController().obs;
  final password = TextEditingController().obs;
  final isLogged = false.obs;
  final admin = false.obs;
  final isAlreadySignIn = false.obs;
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  final userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    userModel.stream.listen((event) {
      return update();
    });
  }

  @override
  void onReady() async {
    super.onReady();

    _user = Rx<User?>(auth.currentUser);
    _user
      ..bindStream(auth.userChanges())
      ..bindStream(auth.idTokenChanges())
      ..bindStream(auth.authStateChanges());

    ever(_user, _initialScreen);

    userModel
      ..update((val) {
        val?.email = _user.value!.email;
        val?.id = _user.value!.uid;
        val?.name = _user.value!.displayName;
      })
      ..subject;
  }

  @override
  void onClose() {
    _user.close();
    logOut();
    super.onClose();
  }

  _initialScreen(User? user) {
    if (user == null) {
      log("login page");
      Get.offAll(() => SignInUI());
    } else {
      Get.offAll(() => ChaTNelView());
    }
  }

  register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (code, message) {
      log('register error code : ${code.code}\nmessage : $message');
    }
  }

  sendPasswordResetEmail(String email, newPassword) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (code, message) {
      log('send password reset email error code : ${code.code}\nmessage : $message');
    }
  }

  login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (code, message) {
      log('login error :code : ${code.code}\nmessage : $message');
    }
  }

  logOut() async {
    await auth.signOut();
  }

  bool checkEmailAlreadyExist(value) {
    if (value == auth.currentUser?.email) {
      return isAlreadySignIn.isTrue;
    } else {
      return isAlreadySignIn.isFalse;
    }
  }
}
