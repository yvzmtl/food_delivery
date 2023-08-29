

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/account_widget.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        
        title: Center(child: BigText(text: "Profil",size: 24,color: Colors.white),),
       
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [

            //profile icon
            AppIcon(icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconSize: Dimensions.iconSize24*3,
            size: Dimensions.fontSize15*10,),

            SizedBox(height: Dimensions.height30),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                                //name
                AccountWidget(appIcon: AppIcon(icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: "Yavuz")),
              
                SizedBox(height: Dimensions.height20),
              
                //phone
                AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                backgroundColor: AppColors.yellowColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: "5051234567")),
              
                SizedBox(height: Dimensions.height20),
              
                //email
                AccountWidget(appIcon: AppIcon(icon: Icons.email,
                backgroundColor: Colors.redAccent,
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: "yavuz@gmail.com")),
              
                SizedBox(height: Dimensions.height20),
              
                //address
                AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                backgroundColor: Colors.blueAccent,
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: "İstanbul")),
              
                SizedBox(height: Dimensions.height20),
              
                //message
                AccountWidget(appIcon: AppIcon(icon: Icons.message_outlined,
                backgroundColor: Color.fromARGB(255, 9, 182, 220),
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: "Mesajlar")),

                SizedBox(height: Dimensions.height20),
              
                //logout
                GestureDetector(
                  onTap: () {
                    if (Get.find<AuthController>().userLoggedIn()) {
                      Get.find<AuthController>().clearSharedData();
                      Get.find<CartController>().clear();
                      Get.find<CartController>().clearCartHistory();
                      // Get.toNamed(RouteHelper.getInitial());
                      Get.toNamed(RouteHelper.getSignInPage());
                    }else{
                      print("Zaten çıkış yapılmış");
                    }
                  },
                  child: AccountWidget(appIcon: AppIcon(icon: Icons.logout,
                  backgroundColor: Colors.redAccent,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height10*5/2,
                  size: Dimensions.height10*5),
                  bigText: BigText(text: "Çıkış")),
                ),
            
                
                  ],
                ),
              ),
            )
     
            
          ],
        ),
      ),
    );
  }
}