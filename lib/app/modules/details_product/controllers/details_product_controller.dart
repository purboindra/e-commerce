import 'package:app_8april_2022/app/models/best_selling_model.dart';

import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailsProductController extends GetxController {
  RxBool isReadMore = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Rx<User?> _user;
  var numOfCarts = 0.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
  }

  Future<void> logOut() async {
    Get.offAllNamed(Routes.LOGIN);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> cartListStream(String uid) {
    return firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("cartItems")
        .snapshots();
  }

  Future<void> addCartItems(BestSellingModel product, int numberCarts) async {
    CollectionReference users = firestore.collection('users');
    var uid = _user.value!.uid;
    await users.doc(uid).collection("cartItems").add(
      {
        "id": product.id,
        "name": product.name,
        "imageUrl": product.imageUrl,
        "description": product.description,
        "rating": product.rating,
        "price": product.price,
        "quantity": 1,
      },
    );
    numOfCarts++;
    // final dataWrite = box.write(
    //   "dataCarts",
    //   {
    //     "bestSellingModel": product,
    //     "numberCarts": numberCarts,
    //   },
    // );

    // update();
    Get.snackbar("Added", "You added ${product.name} to your cart!",
        isDismissible: true);
  }

  // saveDataCarts(int numberOfItems) {
  //   box.write("numberCarts", numOfCarts.value);
  //   numOfCarts.value++;
  // }

  @override
  void onInit() {
    super.onInit();
    isReadMore;
  }
}
