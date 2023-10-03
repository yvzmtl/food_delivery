

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_loader.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
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

    bool _userLoggenIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggenIn) {
      Get.find<UserController>().getUserInfo();
      print("account page =  Kullanıcı giriş yapmış");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText(text: "Profil",size: 24,color: Colors.white),),
        ),
        
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggenIn ? 
            (userController.isLoading? Container(
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
                bigText: BigText(text: userController.userModel!.name)),
              
                SizedBox(height: Dimensions.height20),
              
                //phone
                AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                backgroundColor: AppColors.yellowColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: userController.userModel!.phone)),
              
                SizedBox(height: Dimensions.height20),
              
                //email
                AccountWidget(appIcon: AppIcon(icon: Icons.email, 
                backgroundColor: Colors.redAccent,
                iconColor: Colors.white,
                iconSize: Dimensions.height10*5/2,
                size: Dimensions.height10*5),
                bigText: BigText(text: userController.userModel!.email)),
              
                SizedBox(height: Dimensions.height20),
              
                //address
                GetBuilder<LocationController>(builder: (locationController){
                  if (_userLoggenIn && locationController.addressList.isEmpty) {
                    return GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getAddressPage());
                      },
                      child: AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                        backgroundColor: Colors.blueAccent,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5),
                        bigText: BigText(text: "İstanbul")),
                    );
                    }else{
                      return GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getAddressPage());
                      },
                      child: AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                        backgroundColor: Colors.blueAccent,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10*5/2,
                        size: Dimensions.height10*5),
                        bigText: BigText(text: "İstanbul")),
                    );
                    }
                }),
              
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
                      Get.find<LocationController>().clearAddressList();
                      // Get.toNamed(RouteHelper.getInitial());
                      Get.toNamed(RouteHelper.getSignInPage());
                    }else{
                      Get.offNamed(RouteHelper.getSignInPage());
                      print("account page = Zaten çıkış yapılmış");
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
      )
            :CustomLoader()): 
            Container(
              child:Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
              width: double.maxFinite,
              height: Dimensions.height100*2.5,
              margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/login.png",) )
              ),
            ),
            SizedBox(height: Dimensions.height10),
             GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getSignInPage());
              },
               child: Container(
                width: double.maxFinite,
                height: Dimensions.height100,
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(
                  child: BigText(text: "Giriş Yap",color: Colors.white,size: Dimensions.fontSize26,)),
                         ),
             ),
                ],
              )
            ));
          },
        )
    );
  }
}