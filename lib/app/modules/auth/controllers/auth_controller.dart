import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/ui/ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthController extends GetxController {
  static AuthController to = Get.find();

  final email = mat.TextEditingController().obs;
  final name = mat.TextEditingController().obs;
  final password = mat.TextEditingController().obs;
  final isLogged = false.obs;
  final admin = false.obs;
  final firebaseUser = Rxn<User>();
  final firestoreUser = Rxn<UserModel>();
  final FacebookLogin plugin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  late String _sdkVersion;
  late FacebookAccessToken _token;
  late FacebookUserProfile _profile;
  late String _email;
  late String _imageUrl;

  Stream<User?> get user => FirebaseAuth.instance.authStateChanges();

  Stream<UserModel>? streamFirestoreUser() {
    if (firebaseUser.value?.uid != null) {

      return FirebaseFirestore.instance
          .doc('/users/${firebaseUser.value!.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromJson(snapshot.data()!));
    }

    return null;
  }
  
  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser()!);
    }

    if (_firebaseUser == null) {
      Get.toNamed('/login');
    } else {
      Get.toNamed('/home');
    }
  }

  signInWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.value.text.trim(),
          password: password.value.text.trim());
      email.value.clear();
      password.value.clear();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('Sign In ErrorTitle'.tr, 'Auth Sign In Error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  registerWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.value.text,
          password: password.value.text)
          .then((result) async {
        print('uID: ' + result.user!.uid);
        print('email: ' + result.user!.email!);

        //create the new user object
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email,
          name: name.value.text,
          createdAt: DateTime.now(),
          photoUrl: result.user!.photoURL,
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);

        email.value.clear();
        password.value.clear();
        hideLoadingIndicator();
      });
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('Auth Sign Up Error'.tr, 'error message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  isAdmin() async {
    await getUser.then((user) async {
      DocumentSnapshot adminRef = await FirebaseFirestore.instance
          .collection('admin')
          .doc(user!.uid)
          .get();
      if (adminRef.exists) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  googleSignIn(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    showLoadingIndicator();

    try {
      final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      await _auth.signInWithCredential(credential).then((result) async {

        //create the new user object
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email,
          name: result.user!.displayName,
          createdAt: DateTime.now(),
          photoUrl: result.user!.photoURL,
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);

        update();

        hideLoadingIndicator();
      });
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('Auth SignInError'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  facebookSignIn(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    bool isExpress = false;

    showLoadingIndicator();

    try {
      if (isExpress != false) {
        await to.plugin.logIn(permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email
        ]).then((result) async {
          await _auth
              .signInWithCredential(
              FacebookAuthProvider.credential(result.accessToken!.token))
              .then((result) async {

            UserModel _newUser = UserModel(
              uid: result.user!.uid,
              email: result.user!.email,
              name: result.user!.displayName,
              createdAt: DateTime.now(),
              photoUrl: result.user!.photoURL,
            );
            _createUserFirestore(_newUser, result.user!);

            update();

            hideLoadingIndicator();
          });
        });
        await _updateUserFbInfo();
      } else {
        final res = await to.plugin.expressLogin();
        if (res.status == FacebookLoginStatus.success) {
          await _updateUserFbInfo();
        } else {
          hideLoadingIndicator();
          Get.snackbar("Can't make express log in. Try regular log in.",
              'auth sign In Error'.tr,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 7),
              backgroundColor: Get.theme.snackBarTheme.backgroundColor,
              colorText: Get.theme.snackBarTheme.actionTextColor);
        }
      }
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('auth sign In Error Title'.tr, 'auth sign In Error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<User?> get getUser async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> _updateUserFbInfo() async {
    final plugin = to.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile profile;
    String email;
    String imageUrl;

    if (token != null) {
      profile = (await plugin.getUserProfile())!;
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = (await plugin.getUserEmail())!;
      }
      imageUrl = (await plugin.getProfileImageUrl(width: 100))!;
    }

    _token = token!;
    // _profile = profile;
    // _email = email;
    // _imageUrl = imageUrl;

    final UserModel userModel = UserModel(
      uid: _profile.userId,
      email: _email,
      name: _profile.name,
      photoUrl: _imageUrl,
      createdAt: DateTime.now(),
    );

    _createUserFirestore(userModel, firebaseUser.value!);
  }

  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
      String password) async {
    try {
      showLoadingIndicator();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user!
            .updateEmail(user.email!)
            .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
      });
      hideLoadingIndicator();
      Get.snackbar('auth.updateUserSuccessNoticeTitle'.tr,
          'auth.updateUserSuccessNotice'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on PlatformException catch (error) {

      hideLoadingIndicator();
      print(error.code);
      String authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = 'auth wrong Password Notice'.tr;
          break;
        default:
          authError = 'auth unknown Error'.tr;
          break;
      }
      Get.snackbar('auth wrong Password Notice Title'.tr, 'auth Error'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    showLoadingIndicator();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.value.text);
      hideLoadingIndicator();
      Get.snackbar(
          'auth reset Password Notice Title'.tr, 'auth reset Password Notice'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
      update();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('auth reset Password Failed'.tr, 'error message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> _googleSignOut() async {
    await _googleSignIn.signOut().then((value) => Get.toNamed('/login'));
  }

  Future<void> signOut() {
    name.value.clear();
    email.value.clear();
    password.value.clear();
    _googleSignOut();
    plugin.logOut();
    return FirebaseAuth.instance.signOut();
  }

  void _updateUserFirestore(UserModel user, User _firebaseUser) {
    FirebaseFirestore.instance
        .doc('/users/${_firebaseUser.uid}')
        .update(user.toJson());
    update();
  }

  void _createUserFirestore(UserModel user, User _firebaseUser) {
    FirebaseFirestore.instance
        .doc('/users/${_firebaseUser.uid}')
        .set(user.toJson());
    update();
  }

  @override
  void onReady() async {
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    name.close();
    email.close();
    password.close();
    super.onClose();
  }

}
