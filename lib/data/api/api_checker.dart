

import 'package:flutter_food_delivery/base/show_custom_snackbar.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response){
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      showCustomSnackbar(response.statusText!);
    }
  }
}