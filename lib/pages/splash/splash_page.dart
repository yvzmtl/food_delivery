import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'dart:async';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivityChanged;



  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    if (Get.find<AuthController>().isLoading) {
      await Get.find<UserController>().getUserInfo();
      await Get.find<LocationController>().getAddressList();
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        var address = Get.find<LocationController>().addressList[0];
        await Get.find<LocationController>().saveUserAddress(address);
      }
    }
   }

   void _removeResource(){
    Get.find<CartController>().clear();
    Get.find<CartController>().removeCartSharedPreference();
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_connectivityChanged = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    bool _firstTime = true;

    Get.find<AuthController>().updateToken();

    _connectivityChanged = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      // ignore: dead_code
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
      }
    },);


    _loadResource();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

  Timer(Duration(seconds: 3), () {
    Get.offNamed(RouteHelper.getInitial());
   });

  }

    @override
  void dispose() {
    controller.dispose();
    _connectivityChanged.cancel();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/image/food_logo2.png",width: Dimensions.splashImg250))),
          //Center(child: Image.asset("assets/image/food_logo_text.png",width: 230)),
        ],
      ),
    );
  }
  
 
}