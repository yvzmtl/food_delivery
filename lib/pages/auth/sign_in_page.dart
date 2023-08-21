import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/show_custom_snackbar.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/pages/auth/sign_up_page.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_text_field.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar("Ad soyad alanı boş olamaz", title: "Uyarı");
      } else if (password.isEmpty) {
        showCustomSnackbar("Şifre alanı boş olamaz", title: "Uyarı");
      } else if (password.length < 6) {
        showCustomSnackbar("Şifre 6 karakterden küçük olamaz", title: "Uyarı");
      } else {
        // showCustomSnackbar("Kayıt Başarılı",title: "Uyarı");

        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
            print("hata mesajı : "+status.message);
     
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),

            // app logo
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

            //welcome
            Container(
              margin: EdgeInsets.only(left: Dimensions.width10 * 2),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Merhaba",
                    style: TextStyle(
                        fontSize: Dimensions.height10 * 5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height10 * 4),

            //Email
            AppTextWidget(
                textController: emailController,
                textinputtype: TextInputType.emailAddress,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20),

            //Password
            AppTextWidget(
                textController: passwordController,
                textinputtype: TextInputType.visiblePassword,
                hintText: "Şifre",
                    icon: Icons.password,
                    isObsurce: true),
            SizedBox(height: Dimensions.height20),

            //Hesabınıza giriş yapın
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.only(right: Dimensions.width10 * 3),
            //       child: RichText(
            //         text: TextSpan(
            //             text: "Hesabınıza Giriş Yapın",
            //             style: TextStyle(
            //                 color: Colors.grey.shade500,
            //                 fontSize: Dimensions.fontSize20)),
            //       ),
            //     ),
            //   ],
            // ),

            SizedBox(height: Dimensions.height10 * 6),

            GestureDetector(
              onTap: () {
                _login(authController);
              },
              child: Container(
                width: Dimensions.screenWidth / 2,
                height: Dimensions.screenHeight / 13,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius30)),
                child: Center(
                  child: BigText(
                    text: "Giriş",
                    size: Dimensions.fontSize20 * 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10 * 5),

            RichText(
              text: TextSpan(
                  text: "Bir kullanıcınız yok mu?",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Dimensions.fontSize20 * 0.8),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => Get.to(() => SignUpPage(),transition: Transition.fade),
                      text: " Kayıt Ol",
                      style: TextStyle(
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.fontSize20 * 0.8,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ],
        ),
          );
        })
    );
  }
}
