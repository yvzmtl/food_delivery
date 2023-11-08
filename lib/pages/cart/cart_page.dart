import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/common_text_button.dart';
import 'package:flutter_food_delivery/base/no_data_page.dart';
import 'package:flutter_food_delivery/base/show_custom_snackbar.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/order_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/models/place_order_model.dart';
import 'package:flutter_food_delivery/pages/order/delivery_options.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/utils/styles.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/app_text_field.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/pages/order/payment_option_button.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
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
        GetBuilder<CartController>(builder: (_cartController){
          return _cartController.getItems.length > 0 ?
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
                                                .popularProductList.indexOf(_cartList[index].product!);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                        } else {
                                          var recommendedIndex = Get.find<RecommendedProductController>()
                                              .recommendedProductList.indexOf(_cartList[index].product!);
                                          if (recommendedIndex<0) {
                                            Get.snackbar("Ürün Geçmişi", "Geçmiş ürünlerde ürün incelemesi mümkün değil!",
                                              backgroundColor: AppColors.mainColor, colorText: Colors.white);
                                          } else {
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height100,
                                        height: Dimensions.height100,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10,
                                            left: Dimensions.width10),
                                            child: CachedNetworkImage(
                                progressIndicatorBuilder: (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                value: progress.progress,
                                ),
                               ),
                                imageUrl: AppConstants.BASE_URL +AppConstants.UPLOAD_URL +cartController.getItems[index].img!,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                 ),
                               ),
                              ),
                            ),
                                       
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                        child: Container(
                                      // color: Colors.amber,
                                      height: Dimensions.height100,
                                      child: Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                  text: _cartList[index].price!.toString() +" ₺",
                                                  color: Colors.redAccent),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(Dimensions.radius20),
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
                                                                color: AppColors.signColor)),
                                                    SizedBox(
                                                        width:
                                                            Dimensions.width10 /2),
                                                    // BigText(text: popularProduct.quantity.toString()),
                                                    BigText(text: _cartList[index].quantity.toString()),
                                                    SizedBox(width:Dimensions.width10 /2),
                                                    GestureDetector(
                                                        onTap: () {
                                                          cartController.addCartItem(_cartList[index].product!, 1);
                                                        },
                                                        child:
                                                            //  popularProduct.inCartItems >= 20?
                                                            //   Icon(Icons.add, color: Colors.black12):
                                                            Icon(Icons.add,
                                                                color: AppColors.signColor)),
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
            ),
          ): NoDataPage(text: "Sepetinizde Hiç Ürün Yok");
        })
       
      ]),
      bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController) {
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(
         builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeight120+45,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height10,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                  topLeft: Radius.circular(Dimensions.radius20 * 2)),
            ),
            child: cartController.getItems.length > 0 ?
            Column(
              children: [
                InkWell(
                  child: Container(
                    width: double.maxFinite,
                    child: CommonTextButton(text: "Ödeme Seç")
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context, 
                      builder: (_){
                        return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(Dimensions.radius20),
                                      topRight: Radius.circular(Dimensions.radius20)
                                    ),
                                  ),
                                  child: Column(
                                    
                                    children: [
                                      Container(
                                        height: 520,
                                        padding: EdgeInsets.only(
                                          left: Dimensions.width20,
                                          right: Dimensions.width20,
                                          top: Dimensions.height20
                                        ),
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const PaymentOptionButton(
                                              icon: Icons.money,
                                              title: "Nakit Ödeme",
                                              subtitle: "Ödemeyi daha sonra elden gerçekleştir.",
                                              index: 0
                                            ),

                                            SizedBox(height: Dimensions.height10),

                                            const PaymentOptionButton(
                                              icon: Icons.paypal_outlined,
                                              title: "Kartla Ödeme",
                                              subtitle: "Ödemenin güvenli ve hızlı yolu",
                                              index: 1
                                            ),

                                            SizedBox(height: Dimensions.height30),
                                            Text('Teslimat ayarları',style: robotoMedium),
                                            DeliveryOptions(
                                              value: "delivery", 
                                              title: "Evde teslim", 
                                              amount: double.parse(Get.find<CartController>().totalAmount.toString()), 
                                              isFree: false),

                                            SizedBox(height: Dimensions.height10/2),

                                            DeliveryOptions(
                                              value: "take away", 
                                              title: "Paket", 
                                              amount: 10.0, 
                                              isFree: true),

                                            SizedBox(height: Dimensions.height20),

                                            AppTextWidget(
                                              textController: _noteController, 
                                              hintText: 'Notunuzu yazabilirsiniz', 
                                              icon: Icons.note,
                                              maxLines: true
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                    
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).whenComplete(() => orderController.setFoodNote(_noteController.text.trim()));
                  },
                ),
                SizedBox(height: Dimensions.height10/2),
                Row(
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
                          //  cartController.totalAmount <= 0?
                          // null:
                          () {
                        // popularProduct.addItem(product);
                        if(Get.find<AuthController>().userLoggedIn()){
                          if (Get.find<LocationController>().addressList.isEmpty) {
                            Get.toNamed(RouteHelper.getAddressPage());
                          }else{
                            // Get.offNamed(RouteHelper.getInitial());
                            //Get.offAllNamed(RouteHelper.getPaymentPage("100127", Get.find<UserController>().userModel!.id));
                            var location = Get.find<LocationController>().getUserAddress();
                            var cart = Get.find<CartController>().getItems;
                            var user = Get.find<UserController>().userModel;
                            PlaceOrderBody placeOrder = PlaceOrderBody(
                              cart: cart, 
                              orderAmount: 100.0, 
                              distance: 10.0, 
                              scheduleAt: '', 
                              orderNote: orderController.foodNote, 
                              address: location.address, 
                              latitude: location.latitude, 
                              longitude: location.longitude, 
                              contactPersonName: user!.name, 
                              contactPersonNumber: user!.phone,
                              orderType: orderController.orderType,
                              paymentMethod: orderController.paymentIndex == 0? 'cash_on_delivery':'digital_payment'
                            );
                            // print("sipariş "+placeOrder.toJson().toString());
                            // return;
                            Get.find<OrderController>().placeOrder(placeOrder,_callback);
                          }
                        //cartController.addToCartHistory();
                        }else{
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: CommonTextButton(text: "Sipariş Ver"),
                    ),
                  ],
                ),
              ],
            ):Container()
          );
        },
      );
      },)
    );
  }

  void _callback(bool isSuccess,String message,String orderID){
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToCartHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
      Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackbar(message);
    }
  }
}
