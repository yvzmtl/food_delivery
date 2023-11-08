

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';

class AppTextWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final TextInputType? textinputtype;
  bool isObsurce;
  bool maxLines;
   AppTextWidget({super.key, 
    required this.textController, 
    required this.hintText, 
    required this.icon, 
    this.textinputtype,
    this.isObsurce=false,
    this.maxLines = false});

  @override
  Widget build(BuildContext context) {
    // var emailController = TextEditingController();
    return Container(
             margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(1, 10),
                  color: Colors.grey.withOpacity(0.2)
                )
              ]
            ),
            child: TextField(
              maxLines: maxLines?3:1,
              obscureText: isObsurce?true:false,
              controller: textController,
              keyboardType: textinputtype,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(icon, color: AppColors.yellowColor),
                // prefix: Icon(icon),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.white
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.white
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30)
                ),
              ),
            ),
          );
  }
}