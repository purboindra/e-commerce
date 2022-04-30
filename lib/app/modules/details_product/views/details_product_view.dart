import 'package:app_8april_2022/app/models/best_selling_model.dart';
import 'package:app_8april_2022/app/modules/cart/controllers/cart_controller.dart';
import 'package:app_8april_2022/app/routes/app_pages.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/details_product_controller.dart';

class DetailsProductView extends GetView<DetailsProductController> {
  final BestSellingModel bestSellingModel = Get.arguments;
  final int? index = 0;
  @override
  Widget build(BuildContext context) {
    this.index;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: Get.width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("${bestSellingModel.imageUrl}"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 60,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                          // margin: EdgeInsets.only(left: 20, top: 50),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 243, 243)
                                .withAlpha(100),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            size: 48,
                          )),
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .cartListStream(controller.auth.currentUser!.uid),
                        builder: (context, snapshotCarts) {
                          if (snapshotCarts.connectionState ==
                              ConnectionState.active) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    "assets/love_filled.png",
                                    color: Colors.white,
                                    width: 32,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.offAllNamed(Routes.CART);
                                      // controller.numOfCarts.value;
                                    },
                                    child: Badge(
                                        badgeColor: Colors.black,
                                        badgeContent: Text(
                                          "${snapshotCarts.data!.docs.length}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins"),
                                        ),
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                          size: 32,
                                        ))),
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${bestSellingModel.name}",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                      Text(
                        "${bestSellingModel.price}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 36,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${bestSellingModel.rating}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(112 Reviewers)",
                        style: TextStyle(
                          color: Color.fromARGB(255, 140, 140, 140),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "About this product",
                    style: TextStyle(
                      // fontFamily: "Poppins",
                      fontSize: 18,
                      // color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText(bestSellingModel.description.toString()),
                        TextButton(
                          onPressed: () {
                            controller.isReadMore.toggle();
                          },
                          child: Text(
                              (controller.isReadMore.value
                                  ? "Read Less"
                                  : "Read More"),
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AddToCart(
                    bestSellingModel: bestSellingModel,
                    index: index!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText(String text) {
    final lines = controller.isReadMore.value == true ? null : 2;
    return (Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 140, 140, 140),
        height: 1.5,
      ),
      maxLines: lines,
      overflow: controller.isReadMore.value
          ? TextOverflow.visible
          : TextOverflow.ellipsis,
    ));
  }
}

class AddToCart extends StatelessWidget {
  final cartController = Get.put(CartController());
  final detailsC = Get.find<DetailsProductController>();
  AddToCart({
    Key? key,
    this.bestSellingModel,
    required this.index,
  }) : super(key: key);
  final BestSellingModel? bestSellingModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.all(
                20,
              ),
            ),
            onPressed: () {},
            child: Text(
              "Buy Now",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.all(
              20,
            ),
          ),
          onPressed: () {
            detailsC.addCartItems(bestSellingModel!, detailsC.numOfCarts.value);
            // detailsC.dataCart();
            // detailsC.saveDataCarts(detailsC.dataCart());
            // detailsC.dataCart(detailsC.numOfCarts.value);
          },
          child: Icon(Icons.shopping_cart),
        ),
      ],
    );
  }
}
