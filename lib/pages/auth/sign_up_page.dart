import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/pages/auth/sign_in_page.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_text_field.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["twitter2.png", "facebook.png", "google.png"];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),

            Container(
              height: Dimensions.screenHeight * 0.25,
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/image/logo_part1.png"),
                ),
              ),
            ),

            //Email
            AppTextWidget(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20),

            //Password
            AppTextWidget(
                textController: passwordController,
                hintText: "Şifre",
                icon: Icons.password),
            SizedBox(height: Dimensions.height20),

            //Name
            AppTextWidget(
                textController: nameController,
                hintText: "Ad Soyad",
                icon: Icons.account_circle),
            SizedBox(height: Dimensions.height20),

            //Phone
            AppTextWidget(
                textController: phoneController,
                hintText: "Telefon",
                icon: Icons.phone),
            SizedBox(height: Dimensions.height20),

            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius30)),
              child: Center(
                child: BigText(
                  text: "Kayıt Ol",
                  size: Dimensions.fontSize20 * 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),

            RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignInPage()),
                  text: "Zaten bir kullanıcınız var mı?",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Dimensions.fontSize20 * 0.8),
                  children: [
                    TextSpan(
                      recognizer:TapGestureRecognizer()..onTap = () => Get.to(() => SignInPage()),
                      text: " Giriş Yap",
                      style: TextStyle(
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.fontSize20 * 0.8,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            SizedBox(height: Dimensions.height30),

            RichText(
              text: TextSpan(
                  text: "Başka metodlarla kayıt ol",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Dimensions.fontSize20 * 0.8)),
            ),

            Wrap(
              children: List.generate(3,(index) => Container(
                height: Dimensions.height10 * 7,
                width: Dimensions.width10 * 7,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/image/" + signUpImages[index]),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
