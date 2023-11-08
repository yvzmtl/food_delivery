import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15),
      child: Center(child: BigText(text: text, color: Colors.white)),
      decoration: BoxDecoration(
        boxShadow:  [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 10,
            color: AppColors.mainColor.withOpacity(0.3)
          )
        ],
        borderRadius: BorderRadius.circular(Dimensions.radius20), color: AppColors.mainColor),
      
    );
  }
}
