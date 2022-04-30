import 'package:app_8april_2022/app/controller/page_index_controller.dart';
import 'package:app_8april_2022/app/models/best_selling_model.dart';
import 'package:app_8april_2022/app/modules/details_product/controllers/details_product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final detailsC = Get.put(DetailsProductController());
  final pageIndexController = Get.put(PageIndexController());

  final BestSellingModel bestSellingModel = BestSellingModel();
  @override
  Widget build(BuildContext context) {
    final detailsController = Get.find<DetailsProductController>();
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: detailsController
              .cartListStream(detailsController.auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var dataCart = snapshot.data!.docs;
              if (dataCart.isNotEmpty) {
                return ListView.builder(
                    itemCount: dataCart.length,
                    itemBuilder: (context, index) {
                      var dataListCart = dataCart[index].data();
                      // return database.getProducts();
                      return cartItems(dataListCart: dataListCart);
                    });
              } else {
                return Center(
                  child: Text(
                    "You have nothing here!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                );
              }
            }
            return SizedBox();
          }),
    );
  }

  _bottomNavBar() {
    return SlidingClippedNavBar.colorful(
      fontWeight: FontWeight.w500,
      selectedIndex: 1,
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
    );
  }
}

class ProductCart extends StatelessWidget {
  final BestSellingModel carts;
  final int index;

  const ProductCart({
    Key? key,
    required this.carts,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image.network(
                carts.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${carts.name}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${carts.price}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      children: [],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class cartItems extends StatelessWidget {
  const cartItems({
    Key? key,
    required this.dataListCart,
  }) : super(key: key);

  final Map<String, dynamic> dataListCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  "${dataListCart["imageUrl"]}",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${dataListCart["name"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${dataListCart["price"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${dataListCart["quantity"]}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.minimize_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
