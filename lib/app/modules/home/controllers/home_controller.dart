import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late User? _user;
  UserModel? userModel;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _user
      ?..getIdToken()
      ..email
      ..photoURL
      ..displayName
      ..uid
      ..refreshToken
      ..emailVerified
      ..tenantId
      ..reload();
  }

  @override
  void onReady() {
    super.onReady();
    userModel = UserModel(
      id: _user?.uid,
      name: _user?.displayName,
      avatarUrl: _user?.photoURL,
      email: _user?.email,
    );
  }

  @override
  void onClose() {}
}
