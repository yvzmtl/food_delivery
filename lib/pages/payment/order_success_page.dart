
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_button.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({super.key, required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1),() {
        // Get.dialog(PaymentFailedDialog(orderID: orderID),barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(width: Dimensions.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(status == 1 ? Icons.check_circle_outline:Icons.warning_amber_outlined,
              size: Dimensions.fontSize20*5,
              color: AppColors.mainColor),

            // Image.asset(status == 1 ? "assets/image/checked.png" : "assets/image/warning.png",
            //  width: Dimensions.width10*10,
            //  height: Dimensions.height10*10,),
            SizedBox(height: Dimensions.height15*2),
            Text(status == 1 ? 'Sipariş başarıyla oluşturuldu' : 'Sipariş verilemedi', style: TextStyle(fontSize: Dimensions.fontSize20)),
            SizedBox(height: Dimensions.height10),
            Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,vertical: Dimensions.height20),
              child: Text(status == 1 ? "Sipariş başarılı" : "Sipariş veilemedi",
                style: TextStyle(fontSize: Dimensions.fontSize20, color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center
              ),
            ),
            SizedBox(height: Dimensions.height10),

            Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: CustomButton(buttonText: "Anasayfaya Dön",
                onPressed: () => Get.offAllNamed(RouteHelper.getInitial()),
              )
            )
          ],
        )),
      ),
    );
  }
}