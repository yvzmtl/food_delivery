import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/pages/home/food_page_body.dart';
import 'package:flutter_food_delivery/pages/home/main_food_page.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/expandable_text_widget.dart';
import 'package:flutter_food_delivery/widgets/food_info.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    //print("page id =" + pageId.toString());
    //print("product name =" + product.name.toString());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite, //genişlik olarak ekranı kapla
                height: Dimensions.popularFoodImageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!),
                        fit: BoxFit.cover)),
              ),
            ),
            //icon widgets
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        //Get.back();
                        Get.to(() => MainFoodPage());
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 0,
                          top: 0,
                          child:AppIcon(icon: Icons.circle,size: 20,
                          iconColor: Colors.transparent,
                          backgroundColor: AppColors.mainColor), )
                        :Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 5,
                          top: 3,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12, color: Colors.white)
                           ):Container()
                      ],
                    );
                  })
                ],
              ),
            ),
            //yiyecek içeriği
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImageSize - 20,
              child: Container(
                  // margin: EdgeInsets.only(top: Dimensions.height20),
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodInfo(text: product.name!, stars: product.stars!),
                      SizedBox(height: Dimensions.height20),
                      BigText(text: "Açıklama"),
                      SizedBox(height: Dimensions.height20),
                      Expanded(
                        child: SingleChildScrollView(
                          child:
                              ExpandableTextWidget(text: product.description!),
                        ),
                      )
                    ],
                  )),
            ),
            //expandable text widget[]
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
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
                      GestureDetector(
                          // onTap: popularProduct.inCartItems+ popularProduct.quantity <= 0
                          //     ? null
                          //     : () {
                          //         popularProduct.setQuantity(false);
                          //       },

                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: 
                          popularProduct.inCartItems+popularProduct.quantity <= 0?
                           Icon(Icons.remove, color: Colors.black12):
                            Icon(Icons.remove, color: AppColors.signColor)
                              ),
                      SizedBox(width: Dimensions.width10 / 2),
                      // BigText(text: popularProduct.quantity.toString()),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10 / 2),
                      GestureDetector(
                          // onTap: popularProduct.inCartItems+popularProduct.quantity >= 20
                          //     ? null
                          //     : () {
                          //         popularProduct.setQuantity(true);
                          //       },
                                 onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child:Icon(Icons.add, color: AppColors.signColor)
                          //  popularProduct.inCartItems+popularProduct.quantity >= 20
                          //     ? Icon(Icons.add, color: Colors.black12)
                          //     : Icon(Icons.add, color: AppColors.signColor)
                              )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color:
                      // popularProduct.inCartItems+ popularProduct.quantity <= 0?
                      //  Colors.grey: 
                       AppColors.mainColor),
                  child: GestureDetector(
                    onTap:
                    //  popularProduct.inCartItems+popularProduct.quantity <= 0? 
                    // null: 
                    () {
                            popularProduct.addItem(product);
                          },
                    child: BigText(

                        // text: "\$ ${product.price} | Sepete ekle",
                        text: "${product.price!} ₺ | Sepete ekle",
                        color: 
                        // popularProduct.inCartItems+popularProduct.quantity <= 0? 
                        // Colors.white54:
                         Colors.white),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
