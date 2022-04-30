import 'package:app_8april_2022/app/models/user_model.dart';
import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  String? email, password, name;
  static LoginController instance = Get.find();
  late Rx<User?> _user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;
  var isHidden = true.obs;
  var isAuth = false.obs;
  var rememberMe = false.obs;
  late TextEditingController emailC;
  late TextEditingController passC;
  final box = GetStorage();
  final String boxRead = "authSave";
  var isLoading = false.obs;

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> googleSignInMethod() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.signIn().then((value) {
        _currentUser = value;
      });

      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        final googleAuth = await _currentUser!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        if (credential != null && googleAuth != null) {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) => userCredential = value);
          print("User credential ${userCredential} ");
          CollectionReference users = firestore.collection('users');
          final checkUser = await users.doc(_currentUser!.email).get();
          if (checkUser.data() == null) {
            await users.doc(userCredential!.user!.uid).get();
            await firestore
                .collection("users")
                .doc(userCredential!.user!.uid)
                .set({
              "uid": userCredential!.user!.uid,
              "name": userCredential!.user!.displayName,
              "email": userCredential!.user!.email,
              "password": password,
            });
            final currUser = await users.doc(_currentUser!.email).get();
            print(currUser);
          }
          Get.offAllNamed(Routes.HOME);
        } else {
          print("Gagal");
        }
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", "OOPs");
    }
  }

  void facebookSignInMethod() async {
    FacebookLoginResult result = await _facebookLogin.logIn();

    final accesToken = result.accessToken!.token;

    //  final box = GetStorage();
    CollectionReference users = firestore.collection('users');
    final facebookCredential = FacebookAuthProvider.credential(accesToken);
    print(facebookCredential);
    await auth.signInWithCredential(facebookCredential).then((user) {
      UserModel(
        uid: accesToken,
        name: name,
        email: email,
      );
    });
    final checkUser = await users.doc(facebookCredential.accessToken).get();
    print("FB CREDENTIAL $facebookCredential ");
    if (result.status == FacebookLoginStatus.success) {
      if (checkUser.data() == null) {
        await users.doc(accesToken).get();
        await firestore.collection("users").doc(accesToken).set({
          "uid": accesToken,
          "name": name,
          "email": email,
          "password": password,
        });

        final currUser = await users.doc(facebookCredential.accessToken).get();
        print("currUser $currUser");
      }
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Error", "FB LOGIN ERROR");
    }
  }

  void signInWithEmailAndPassword(
      String email, password, bool rememberMe) async {
    isLoading.value == true;
    try {
      if (email != '' && password != "") {
        if (rememberMe == true) {
          box.write(boxRead, {
            "email": email,
            "password": password,
            "rememberMe": rememberMe,
          });
          await auth.signInWithEmailAndPassword(
              email: email, password: password!);
        } else {
          if (box.read(boxRead) != null) {
            box.erase();
          }
        }
        isAuth.value == true;
        isLoading.value == false;
        Get.offAllNamed(
          Routes.HOME,
        );
      } else {
        Get.snackbar(
          "Error",
          "Email and password must be filled",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    // checkData();
    passC = TextEditingController();
    emailC = TextEditingController();
    if (box.read(boxRead) != null) {
      final data = box.read(boxRead) as Map<String, dynamic>;
      emailC.text = data["email"];
      passC.text = data["password"];
      rememberMe.value = data["rememberMe"];
    }
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
  }

  @override
  void onClose() {
    passC.dispose();
    emailC.dispose();
    // logout();
    super.onClose();
  }
}
