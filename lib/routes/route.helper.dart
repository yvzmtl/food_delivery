import 'package:flutter_food_delivery/models/order_model.dart';
import 'package:flutter_food_delivery/pages/address/add_address_page.dart';
import 'package:flutter_food_delivery/pages/address/pick_address_map.dart';
import 'package:flutter_food_delivery/pages/auth/sign_in_page.dart';
import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/pages/home/home_page.dart';
import 'package:flutter_food_delivery/pages/payment/payment_page.dart';
import 'package:flutter_food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splashPage = "/splash-page";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddAddress = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";


  static String getInitial() => '$initial';
  static String getSplashPage() => '$splashPage';
  static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page) =>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddAddress';
  static String getPaymentPage(String id, int userID)=>'$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage()=>'$orderSuccess';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () {
      return HomePage();
    },transition: Transition.fade),
    
    GetPage(name: splashPage, page: () => SplashScreen()),
    
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),

    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn),

    GetPage(
        name: cartPage,
        page: () {
          //var pageId = Get.parameters['pageId'];
          return CartPage();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        },
        transition: Transition.fadeIn),

    GetPage(name: pickAddAddress, page: () {
          PickAddressMap _pickAddressMap = Get.arguments;
      return _pickAddressMap;
    }),

  GetPage(name: payment, page: ()=>PaymentPage(
    orderModel: OrderModel(
      id: int.parse(Get.parameters['id']!),
      userId: int.parse(Get.parameters['userID']!))
      )
    ),
  ];
}
