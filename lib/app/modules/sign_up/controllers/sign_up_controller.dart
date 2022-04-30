import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email, password, name;
  static SignUpController instance = Get.find();
  UserCredential? userCredential;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void registerUser(String email, password, name) async {
    try {
      isLoading.value = true;
      UserCredential _userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = _userCredential.user!.uid;

      CollectionReference users = firestore.collection('users');
      var checkUser = await users.doc(uid).get();
      if (checkUser.data() == null) {
        await users.doc(_userCredential.user!.uid).get();

        await firestore.collection("users").doc(uid).set({
          "uid": uid,
          "name": name,
          "email": email,
          "password": password,
        });
      }

      print(uid);
      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print(e.code);
      if (e.code == 'weak-password') {
        Get.snackbar("Something Wrong", "Your password is to week to use!");
      } else if (e.code == 'email-already-in-use') {
        isLoading.value = false;
        Get.snackbar(
            "Something Wrong", "That's user is already have an account!");
      } else if (e.code == "wrong-password") {
        isLoading.value = false;
        Get.snackbar("Something Wrong", "Coldn't login, wrong password");
      } else {
        isLoading.value = false;
        Get.snackbar("Something Wrong", e.code);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Something Wrong", "Cannot added the employe!");
    }
  }
}
