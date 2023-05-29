import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/no_data_page.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (var i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList(); //3 , 2 , 4...

    var listCounter = 0;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        var outputDate =AppConstants.datetimeFormat(getCartHistoryList[listCounter].time!);
      }
      return BigText(text:outputDate);
    }

    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimensions.height100,
          color: AppColors.mainColor,
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(text: "Tüm Siparişlerim", color: Colors.white),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (_cartController){
          return _cartController.getCartHistoryList().length > 0 ?
          Expanded(
          child: Container(
          // color: Colors.blueAccent,
          margin: EdgeInsets.only(
              top: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20),
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              children: [
                for (int i = 0; i < itemsPerOrder.length; i++)
                  Container(
                    height: Dimensions.height120,
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BigText(text: AppConstants.datetimeFormat(getCartHistoryList[listCounter].time!)),
                        timeWidget(listCounter),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children:
                                  List.generate(itemsPerOrder[i], (index) {
                                if (listCounter < getCartHistoryList.length) {
                                  listCounter++;
                                }
                                return index <= 2
                                    ? Container(
                                        height: Dimensions.height80,
                                        width: Dimensions.width20 * 4,
                                        margin: EdgeInsets.only(
                                            right: Dimensions.width10 / 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +
                                                  getCartHistoryList[listCounter - 1].img!),
                                            )),
                                      )
                                    : Container();
                              }),
                            ),
                            Container(
                              height: Dimensions.height80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SmallText(text: "Toplam",color: AppColors.titleColor),
                                  BigText(text: itemsPerOrder[i].toString()+" Ürün",color: AppColors.titleColor),
                                  GestureDetector(
                                    onTap: () {
                                      var orderTime = cartOrderTimeToList();
                                      print("Sipariş zamanı = "+AppConstants.datetimeFormat(orderTime[i]));
                                      Map<int,CartModel> moreOrder = {};
                                      for (int j = 0; j < getCartHistoryList.length; j++) {
                                        if (getCartHistoryList[j].time == orderTime[i]) {
                                          moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => 
                                            CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                          );
                                        print("Benim sipariş zamanım = "+AppConstants.datetimeFormat(orderTime[i]));
                                        print("Ürün bilgisi = "+jsonEncode(getCartHistoryList[j]));
                                        }
                                      }
                                      Get.find<CartController>().setItems = moreOrder;
                                      Get.find<CartController>().addToCartList();
                                      Get.toNamed(RouteHelper.getCartPage());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2,
                                                                    vertical: Dimensions.height10/2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                      ),
                                      child: SmallText(text: "Daha Fazla",color: AppColors.mainColor,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          ),
          ): 
          SizedBox(
            height: MediaQuery.of(context).size.height/1.5,
            child: const Center(
              child: NoDataPage(text: "Hiç Siparişiniz Yok",imgPath: "assets/image/empty_cart_history.png")));
        }),
      ]),
    );
  }
}
