
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/order_controller.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/utils/styles.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions({super.key, 
    required this.value, 
    required this.title, 
    required this.amount, 
    required this.isFree
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
      children: [
        Radio(
          value: value, 
          groupValue: orderController.orderType,
          activeColor: Theme.of(context).primaryColor, 
          onChanged: (String? value){orderController.setDeliveryType(value!);}
        ),
        SizedBox(width: Dimensions.width10/2),
        Text(title,style: robotoRegular),
        SizedBox(width: Dimensions.width10/2),
        Text( '(${(value== 'take away' || isFree)?'free':'${amount/10} ₺'})',
          style: robotoMedium)
        ],
      );
    });
  }
}