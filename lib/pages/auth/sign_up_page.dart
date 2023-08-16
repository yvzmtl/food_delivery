import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/show_custom_snackbar.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/models/signup_model.dart';
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
    var repeatpasswordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["twitter2.png", "facebook.png", "google.png"];


     void _registration(){
      var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String repeatpassword = repeatpasswordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar("Ad soyad alanı boş olamaz",title: "Uyarı");
      }else if(phone.isEmpty){
        showCustomSnackbar("Telefon alanı boş olamaz",title: "Uyarı");
      }else if(email.isEmpty){
        showCustomSnackbar("Email alanı boş olamaz",title: "Uyarı");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackbar("Uygun bir email değil",title: "Uyarı");
      }else if(password.isEmpty){
        showCustomSnackbar("Şifre alanı boş olamaz",title: "Uyarı");
      }
     
      else if(password != repeatpassword){
        showCustomSnackbar("Şifreler eşleşmiyor",title: "Uyarı");
      }else if(password.length < 6){
        showCustomSnackbar("Şifre 6 karakterden küçük olamaz",title: "Uyarı");
      }
      // else if(phone.length != 10){
      //   showCustomSnackbar("Telefon numarası eksik veya hatalı girildi ",title: "Uyarı");
      // }
      else{
        // showCustomSnackbar("Kayıt Başarılı",title: "Uyarı");
        SignUpModel signUpModel = SignUpModel(name: name, 
          phone: phone, 
          email: email, 
          password: password);
        authController.registration(signUpModel).then((status){
          if (status.isSuccess) {
            print("kayıt başarılı");
          }
          else{
            showCustomSnackbar(status.message);
          }
        });
      }
    }

     
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight * 0.05),

            Container(
              height: Dimensions.screenHeight * 0.2,
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
                textinputtype: TextInputType.emailAddress,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height10*1.5),

            //Password
            AppTextWidget(
                textController: passwordController,
                textinputtype: TextInputType.visiblePassword,
                hintText: "Şifre",
                icon: Icons.password),
            SizedBox(height: Dimensions.height10*1.5),

             //Repeat Password
             AppTextWidget(
                textController: repeatpasswordController,
                textinputtype: TextInputType.visiblePassword,
                hintText: "Şifre Tekrar",
                icon: Icons.password),
            SizedBox(height: Dimensions.height10*1.5),

            //Name
            AppTextWidget(
                textController: nameController,
                textinputtype: TextInputType.text,
                hintText: "Ad Soyad",
                icon: Icons.account_circle),
            SizedBox(height: Dimensions.height10*1.5),

            //Phone
            AppTextWidget(
                textController: phoneController,
                textinputtype: TextInputType.phone,
                hintText: "Telefon(5*********)",
                icon: Icons.phone),
            SizedBox(height: Dimensions.height10*1.5),

            GestureDetector(
             onTap: () {
               _registration();
             },
              child: Container(
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

            // RichText(
            //   text: TextSpan(
            //       text: "Başka metodlarla kayıt ol",
            //       style: TextStyle(
            //           color: Colors.grey.shade500,
            //           fontSize: Dimensions.fontSize20 * 0.8)),
            // ),

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
