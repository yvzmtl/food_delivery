import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(
      () => PopularProductController(popularProductRepository: Get.find()));
}
