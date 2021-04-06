import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/modules/auth/auth.dart';
import 'package:fire_chat_v2/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get_server/get_server.dart';
import 'package:get/get.dart' as g;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class AuthService extends GetxService {
  static AuthService to = Get.find();

  final firestoreUser = Rxn<UserModel>();
  final firebaseUser = Rxn<User>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FacebookLogin _facebookLogin = FacebookLogin();

  Stream<User?> onAuthChanged() => _firebaseAuth.authStateChanges();

  Stream<UserModel>? streamFirestoreUser() {
    if (firebaseUser.value?.uid != null) {
      return FirebaseFirestore.instance
          .doc('/users/${firebaseUser.value!.uid}')
          .snapshots()
          .map((event) => UserModel.fromJson(event.data()!));
    }
    return null;
  }

  String getToken() {
    final claimSet = JwtClaim(
      maxAge: const Duration(minutes: 5),
      expiry: DateTime.now().add(Duration(days: 3)),
      issuer: 'get_example',
      issuedAt: DateTime.now(),
    );

    return TokenUtil.generateToken(claim: claimSet);
  }

  handleAuthChanged(_firebaseUser) async {
    if (_firebaseUser.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser()!);
    }

    if (_firebaseUser == null) {
      g.Get.to(() => SignInUI());
    } else {
      g.Get.to(() => Routes.HOME);
    }
  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // g.Get.snackbar(title, message);
    }
  }

  registerWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // g.Get.snackbar(title, message);
    }
  }

  signUp(String email, String password, {String? username}) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user!.uid;
  }

  getAccessToken() async {
    User user = (await (getCurrentUser()))!;
    IdTokenResult tokenResult = (await user.getIdToken()) as IdTokenResult;
    return tokenResult.token;
  }

  getRefreshToken() async {
    User user = _firebaseAuth.currentUser!;
    IdTokenResult tokenResult = (await user.getIdToken()) as IdTokenResult;
    return tokenResult.token;
  }

  deleteUser() async {
    User user = _firebaseAuth.currentUser!;
    user.delete().then((_) {
      print('Successful user deleted');
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

  googleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount googleSignInAccount =
          (await (_googleSignIn.signIn()))!;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      await _firebaseAuth.signInWithCredential(credential).then((result) async {
        UserModel _newUser = UserModel(
            uid: result.user!.uid,
            email: result.user!.email,
            name: result.user!.displayName,
            photoUrl: result.user!.photoURL,
            createdAt: DateTime.now());
      });
    } catch (error) {}
  }

  facebookSignIn() async {
    bool? isExpress;

    try {
      if (isExpress != false) {
        await to._facebookLogin.logIn(permissions: [
          FacebookPermission.email,
          FacebookPermission.publicProfile
        ]).then((result) async {
          await _firebaseAuth
              .signInWithCredential(
                  FacebookAuthProvider.credential(result.accessToken!.token))
              .then((result) async {
            UserModel _newUser = UserModel(
                uid: result.user!.uid,
                name: result.user!.displayName,
                email: result.user!.email,
                photoUrl: result.user!.photoURL,
                createdAt: DateTime.now());
          });
        });
      } else {
        final res = await to._facebookLogin.expressLogin();
        if (res.status == FacebookLoginStatus.success) {
          await _updateUserFbInfo();
        } else {
          g.Get.snackbar("Can't make express log in. Try regular log in.",
              'Sign In Error',
              snackPosition: g.SnackPosition.BOTTOM,
              duration: Duration(seconds: 7),
              backgroundColor: g.Get.theme.snackBarTheme.backgroundColor,
              colorText: g.Get.theme.snackBarTheme.actionTextColor);
        }
      }
    } catch (error) {
      g.Get.snackbar("Can't make express log in. Try regular log in.",
          'Sign In Error',
          snackPosition: g.SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: g.Get.theme.snackBarTheme.backgroundColor,
          colorText: g.Get.theme.snackBarTheme.actionTextColor);
    }
  }

  isAdmin() async {
    await getUser.then((user) async {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(user!.uid)
          .get();
    });
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> _updateUserFbInfo() async {
    final plugin = to._facebookLogin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;

    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    UserModel _newUser = UserModel(
        uid: profile!.userId,
        name: profile.name,
        email: email,
        photoUrl: imageUrl,
        createdAt: DateTime.now());
  }

  Future<User?> get getUser async {
    return _firebaseAuth.currentUser;
  }

  Future<void> _googleSignOut() async {
    await _googleSignIn.signOut().then((value) => g.Get.offAll(
        // () => SignUpUI()
        null));
  }

  Future<void> signOut() {
    _googleSignOut();
    _facebookLogin.logOut();
    return _firebaseAuth.signOut();
  }
}
