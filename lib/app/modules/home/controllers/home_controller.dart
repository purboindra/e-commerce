// ignore_for_file: deprecated_member_use

import 'package:app_8april_2022/app/models/best_selling_model.dart';
import 'package:app_8april_2022/app/models/categories_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  CollectionReference? collectionReference;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final bestSelling = <BestSellingModel>[].obs;
  final categories = <CategoriesModel>[].obs;
  var isLoading = true.obs;
  RxList<BestSellingModel> products = RxList<BestSellingModel>([]);

  @override
  void onInit() {
    categories.bindStream(getData());
    products.bindStream(getAllProducts(BestSellingModel()));
    super.onInit();
  }

  Stream<List<BestSellingModel>> getAllProducts(
      BestSellingModel bestSellingModel) {
    return firestore.collection("best_selling").snapshots().map((query) {
      return query.docs.map((item) {
        return BestSellingModel.fromJson(item);
      }).toList();
    });
  }

  Stream<List<CategoriesModel>> getData() {
    return firestore.collection("categories").snapshots().map((event) {
      isLoading.value = false;
      return event.docs.map((e) => CategoriesModel.fromJson(e)).toList();
    });
  }
}
