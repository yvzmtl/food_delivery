import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/icon_and_text_widget.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';

class FoodInfo extends StatelessWidget {
  final String text;
  final int stars;
  const FoodInfo({super.key, required this.text, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.fontSize26),
        SizedBox(height: Dimensions.height10),
        Row(children: [
          Wrap(
              children: List.generate(
                  stars,
                  (index) => Icon(Icons.star,
                      color: AppColors.mainColor,
                      size: Dimensions.fontSize15))),
          SizedBox(width: Dimensions.width10),
          SmallText(text: stars.toString()),
          SizedBox(width: Dimensions.width30),
          SmallText(text: "950"),
          SizedBox(width: Dimensions.width10),
          SmallText(text: "yorum"),
        ]),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            //SizedBox(width: 10),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            //SizedBox(width: 10),
            IconAndTextWidget(
                icon: Icons.access_time_filled_rounded,
                text: "30min",
                iconColor: AppColors.iconColor2)
          ],
        ),
      ],
    );
  }
}
