import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // home: SignUpPage(),
         initialRoute: RouteHelper.getSplashPage(),
         getPages: RouteHelper.routes,
        );
      });
    });
  }
}
