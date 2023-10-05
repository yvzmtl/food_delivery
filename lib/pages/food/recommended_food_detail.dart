import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:flutter_food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  //ProductsModel recommendedProductList;
  // RecommendedFoodDetail(this.recommendedProductList, {super.key});
  final int pageId;
  final String page;
  RecommendedFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var recommendedProductList =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(recommendedProductList, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: Dimensions.height80,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Get.toNamed(RouteHelper.getInitial());
                        if (page=="cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.clear)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1) {
                          //Get.to(() => CartPage());
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                            },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 5,
                                  top: 3,
                                  child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white))
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  //color: Colors.white,
                  child: Center(
                      child: BigText(
                          text: recommendedProductList.name!,
                          size: Dimensions.fontSize26)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                      top: Dimensions.height5, bottom: Dimensions.height10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                  background: 
                 CachedNetworkImage(
                                progressIndicatorBuilder: (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                value: progress.progress,
                                ),
                               ),
                                imageUrl: AppConstants.BASE_URL +AppConstants.UPLOAD_URL +recommendedProductList.img!,
                                width: double.maxFinite,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                 ),
                               ),
                              ),
                            ),
                  
                  // Image(
                  //     image: NetworkImage(AppConstants.BASE_URL +
                  //         AppConstants.UPLOAD_URL +
                  //         recommendedProductList.img!),
                  //     width: double.maxFinite,
                  //     fit: BoxFit.cover)




                  // Image.asset("assets/image/food1.png",
                  //     width: double.maxFinite, fit: BoxFit.cover),
                  ),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width15,
                      right: Dimensions.width15,
                      bottom: Dimensions.height20),
                  child: ExpandableTextWidget(
                      text: recommendedProductList.description!),
                )
              ],
            ))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          icon: Icons.remove,
                          iconSize: Dimensions.iconSize24,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white),
                    ),
                    BigText(
                      text:
                          "${recommendedProductList.price!} ₺ X ${controller.inCartItems}",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.fontSize26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                          icon: Icons.add,
                          iconSize: Dimensions.iconSize24,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Icon(Icons.favorite,
                            color: AppColors.mainColor,
                            size: Dimensions.iconSize24 * 1.2)),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(recommendedProductList);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: BigText(
                            text:
                                " ${recommendedProductList.price!} ₺ | Sepete ekle",
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
