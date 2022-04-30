import 'package:get/get.dart';

import '../controllers/details_product_controller.dart';

class DetailsProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsProductController>(
      () => DetailsProductController(),
    );
  }
}
