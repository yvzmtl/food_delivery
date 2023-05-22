import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: Dimensions.height20 * 3,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24),
              ),
              SizedBox(
                width: Dimensions.width20 * 6,
              ),
              GestureDetector(
                onTap: () {
                  //Get.to(() => MainFoodPage());
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24),
              ),
              AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24),
            ],
          ),
        ),
        Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              // color: Colors.red,
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return Container(
                                height: Dimensions.height100,
                                width: double.maxFinite,
                                //  color: Colors.blue,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                  popularIndex, "cartpage"));
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                          Get.toNamed(
                                              RouteHelper.getRecommendedFood(
                                                  recommendedIndex,
                                                  "cartpage"));
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height100,
                                        height: Dimensions.height100,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10,
                                            left: Dimensions.width10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      cartController
                                                          .getItems[index]
                                                          .img!),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                        child: Container(
                                      // color: Colors.amber,
                                      height: Dimensions.height100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                  text: _cartList[index]
                                                          .price!
                                                          .toString() +
                                                      " ₺",
                                                  color: Colors.redAccent),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          
                                                          cartController.addCartItem(_cartList[index].product!, -1);
                                                        },
                                                        child:
                                                            // popularProduct.inCartItems <= 0 ?
                                                            //  Icon(Icons.remove, color: Colors.black12):
                                                            Icon(Icons.remove,
                                                                color: AppColors
                                                                    .signColor)),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2),
                                                    // BigText(text: popularProduct.quantity.toString()),
                                                    BigText(
                                                        text: _cartList[index]
                                                            .quantity
                                                            .toString()),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addCartItem(_cartList[index].product!, 1);
                                                        },
                                                        child:
                                                            //  popularProduct.inCartItems >= 20?
                                                            //   Icon(Icons.add, color: Colors.black12):
                                                            Icon(Icons.add,
                                                                color: AppColors
                                                                    .signColor)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ));
                          });
                    },
                  )),
            ))
      ]),
      bottomNavigationBar: GetBuilder<CartController>(
       
        builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeight120,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                  topLeft: Radius.circular(Dimensions.radius20 * 2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                     
                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(text: cartController.totalAmount.toString()+" ₺"),
                      SizedBox(width: Dimensions.width10 / 2),
                      
                    ],
                  ),
                ),
                GestureDetector(
                  onTap:
                       cartController.totalAmount <= 0?
                      null:
                      () {
                    // popularProduct.addItem(product);
                    cartController.addToCartHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                        left: Dimensions.width15,
                        right: Dimensions.width15),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color:
                            cartController.totalAmount <= 0?
                             Colors.grey:
                            AppColors.mainColor),
                    child: BigText(text: "Sipariş ver",
                        color:Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
