import 'package:get_server/get_server.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  final count = 0.obs;

  String getToken() {
    final claimSet = JwtClaim(
      maxAge: const Duration(minutes: 5),
      expiry: DateTime.now().add(Duration(days: 3)),
      issuer: 'get_example',
      issuedAt: DateTime.now(),
    );

    return TokenUtil.generateToken(claim: claimSet);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

}
