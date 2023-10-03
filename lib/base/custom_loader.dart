
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // print("Yüklenme yeri "+ Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height: Dimensions.height100,
        width: Dimensions.width10*10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height10*5),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}