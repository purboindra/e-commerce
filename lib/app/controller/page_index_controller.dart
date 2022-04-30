import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  // get pageIndexValue => pageIndex;
  void changPage(int index) {
    pageIndex.value = index;
    switch (index) {
      case 0:
        pageIndex.value = index;
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        pageIndex.value = index;
        Get.offAllNamed(Routes.CART);
        break;
      case 2:
        pageIndex.value = index;
        Get.offAllNamed(Routes.CART);
        break;
      default:
        pageIndex.value = index;
        Get.offAllNamed(Routes.HOME);
    }
    update();
  }
}
