import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/order_controller.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/utils/styles.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;

  const PaymentOptionButton({super.key, 
    required this.icon, 
    required this.title, 
    required this.subtitle, 
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (ordercontroller){
      bool _selected = ordercontroller.paymentIndex == index;
      return InkWell(
        onTap: () => ordercontroller.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10/2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1
              )
            ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color:  _selected? AppColors.mainColor :Theme.of(context).disabledColor
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSize20),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                color: Theme.of(context).disabledColor,
                fontSize: Dimensions.fontSize15),
            ),
            trailing: _selected?Icon(Icons.check_circle, color: Theme.of(context).primaryColor):null,
          ),
        ),
      );
    });
  }
}