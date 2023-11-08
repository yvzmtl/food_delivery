

import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool backButtonExists;
  final Function? onBackPressed;

  const CustomAppBar({super.key, 
    required this.title, 
    this.backButtonExists = true,
    this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      title: BigText(text: title,color: Colors.white),
      centerTitle: true,
      leading: backButtonExists?IconButton(
        onPressed: () => onBackPressed!=null?onBackPressed!():
          Navigator.pushReplacementNamed(context, "/initial"),
        icon: Icon(Icons.arrow_back_ios)):null
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(500, 50);
  

}