import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/expandable_text_widget.dart';
import 'package:flutter_food_delivery/widgets/food_info.dart';
import 'package:flutter_food_delivery/widgets/icon_and_text_widget.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite, //genişlik olarak ekranı kapla
              height: Dimensions.popularFoodImageSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/image/food1.png",
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_bag_outlined),
              ],
            ),
          ),
          //yiyecek içeriği
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImageSize - 20,
            child: Container(
                // margin: EdgeInsets.only(top: Dimensions.height20),
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FoodInfo(text: "Pasta"),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "İçerik"),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                            text: "Altyapı Akademileri Projesi kapsamında Altyapı Akademilerinde Türkiye Modeli oluşturmak ve sürdürebilmek adına TFF Başkanı Mehmet Büyükekşi ile yönetim kurulu üyelerinin kulüp akademilerini ziyaret ederek yaptığı toplantılar Ankara kulüpleriyle devam etti." +
                                "Toplantılarda TFF Başkan Vekili Nüket Küçükel Ezberci, Süper Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Müslüm Özmen ve 1. Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Talat Papatya da hazır bulundu." +
                                "TFF Başkanı Mehmet Büyükekşi ve yönetim kurulu üyelerinin Ankara'daki ilk durağı MKE Ankaragücü oldu. Ankaragücü Başkanı Faruk Koca ve yönetim kurulu üyelerinin ev sahipliğinde yapılan toplantıda kulübün Gençlik Geliştirme Programı Sorumlusu Ümit Turmuş da TFF heyetine bir sunum yaptı."),
                      ),
                    )
                  ],
                )),
          ),
          //expandable text widget[]
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeight120,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20 * 2),
              topLeft: Radius.circular(Dimensions.radius20 * 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimensions.width10 / 2),
                  BigText(text: "0"),
                  SizedBox(width: Dimensions.width10 / 2),
                  Icon(Icons.add, color: AppColors.signColor)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor),
              child: BigText(text: " 10\$ | Sepete ekle", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
