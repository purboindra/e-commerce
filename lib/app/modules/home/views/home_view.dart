import 'package:app_8april_2022/app/controller/page_index_controller.dart';
import 'package:app_8april_2022/app/modules/cart/controllers/cart_controller.dart';
import 'package:app_8april_2022/app/modules/login/controllers/login_controller.dart';
import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageIndexController = Get.put(PageIndexController());
  final productC = Get.put(CartController());
  final loginC = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () => loginC.logout()),
      backgroundColor: Color.fromARGB(255, 248, 254, 255),
      bottomNavigationBar: _bottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            child: Obx(
              () {
                if (controller.isLoading.isTrue) {
                  return Container(
                    height: Get.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (controller.products.isNotEmpty &&
                    controller.categories.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _searchField(),
                      SizedBox(height: 30),
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Categories(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Best Selling',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BestSelling(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text("Error"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //

  _bottomNavBar() {
    return Container(
      child: SlidingClippedNavBar.colorful(
        fontWeight: FontWeight.w500,
        selectedIndex: pageIndexController.pageIndex.value,
        onButtonPressed: (int value) {
          pageIndexController.changPage(value);
        },
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Home',
            activeColor: Color.fromARGB(255, 238, 137, 4),
            inactiveColor: Color(0xff6789c6),
          ),
          BarItem(
            icon: Icons.shopping_cart,
            title: 'Cart',
            activeColor: Color.fromARGB(255, 238, 137, 4),
            inactiveColor: Color(0xff6789c6),
          ),
          BarItem(
            icon: Icons.person,
            title: 'Profile',
            activeColor: Color.fromARGB(255, 238, 137, 4),
            inactiveColor: Color(0xff6789c6),
          ),
        ],
        // activeColor: Color(0xFF01579B),
        backgroundColor: Color.fromARGB(255, 248, 254, 255),
      ),
    );
  }

  TextField _searchField() {
    return TextField(
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: "Find something awesome, here!",
        hintText: "Search",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}

class BestSelling extends StatelessWidget {
  final controller = Get.find<HomeController>();
  BestSelling({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 350,
          child: ListView.builder(
              itemCount: controller.products.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILS_PRODUCT,
                        arguments: controller.products[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Row(
                      children: [
                        Card(
                          elevation: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 250,
                                    width: Get.width * .5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${controller.products[index].imageUrl}"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 75,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "${controller.products[index].rating}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.products[index].name}",
                                      // textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        // fontFamily: "Poppins",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${controller.products[index].price.toString()}",
                                      // textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}

class Categories extends StatelessWidget {
  final homeController = Get.put(HomeController());
  Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 110,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: homeController.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                '${homeController.categories[index].imageUrl}'),
                          )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          " ${homeController.categories[index].name}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
