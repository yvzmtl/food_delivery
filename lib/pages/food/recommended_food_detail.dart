import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: Dimensions.height80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                //color: Colors.white,
                child: Center(
                    child: BigText(text: "Pasta", size: Dimensions.fontSize26)),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: Dimensions.height5, bottom: Dimensions.height10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20))),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("assets/image/food1.png",
                  width: double.maxFinite, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                    bottom: Dimensions.height20),
                child: ExpandableTextWidget(
                    text: "Altyapı Akademileri Projesi kapsamında Altyapı Akademilerinde Türkiye Modeli oluşturmak ve sürdürebilmek adına TFF Başkanı Mehmet Büyükekşi ile yönetim kurulu üyelerinin kulüp akademilerini ziyaret ederek yaptığı toplantılar Ankara kulüpleriyle devam etti." +
                        "Toplantılarda TFF Başkan Vekili Nüket Küçükel Ezberci, Süper Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Müslüm Özmen ve 1. Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Talat Papatya da hazır bulundu." +
                        "TFF Başkanı Mehmet Büyükekşi ve yönetim kurulu üyelerinin Ankara'daki ilk durağı MKE Ankaragücü oldu. Ankaragücü Başkanı Faruk Koca ve yönetim kurulu üyelerinin ev sahipliğinde yapılan toplantıda kulübün Gençlik Geliştirme Programı Sorumlusu Ümit Turmuş da TFF heyetine bir sunum yaptı." +
                        "Altyapı Akademileri Projesi kapsamında Altyapı Akademilerinde Türkiye Modeli oluşturmak ve sürdürebilmek adına TFF Başkanı Mehmet Büyükekşi ile yönetim kurulu üyelerinin kulüp akademilerini ziyaret ederek yaptığı toplantılar Ankara kulüpleriyle devam etti." +
                        "Toplantılarda TFF Başkan Vekili Nüket Küçükel Ezberci, Süper Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Müslüm Özmen ve 1. Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Talat Papatya da hazır bulundu." +
                        "TFF Başkanı Mehmet Büyükekşi ve yönetim kurulu üyelerinin Ankara'daki ilk durağı MKE Ankaragücü oldu. Ankaragücü Başkanı Faruk Koca ve yönetim kurulu üyelerinin ev sahipliğinde yapılan toplantıda kulübün Gençlik Geliştirme Programı Sorumlusu Ümit Turmuş da TFF heyetine bir sunum yaptı." +
                        "Altyapı Akademileri Projesi kapsamında Altyapı Akademilerinde Türkiye Modeli oluşturmak ve sürdürebilmek adına TFF Başkanı Mehmet Büyükekşi ile yönetim kurulu üyelerinin kulüp akademilerini ziyaret ederek yaptığı toplantılar Ankara kulüpleriyle devam etti." +
                        "Toplantılarda TFF Başkan Vekili Nüket Küçükel Ezberci, Süper Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Müslüm Özmen ve 1. Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Talat Papatya da hazır bulundu." +
                        "TFF Başkanı Mehmet Büyükekşi ve yönetim kurulu üyelerinin Ankara'daki ilk durağı MKE Ankaragücü oldu. Ankaragücü Başkanı Faruk Koca ve yönetim kurulu üyelerinin ev sahipliğinde yapılan toplantıda kulübün Gençlik Geliştirme Programı Sorumlusu Ümit Turmuş da TFF heyetine bir sunum yaptı." +
                        "Altyapı Akademileri Projesi kapsamında Altyapı Akademilerinde Türkiye Modeli oluşturmak ve sürdürebilmek adına TFF Başkanı Mehmet Büyükekşi ile yönetim kurulu üyelerinin kulüp akademilerini ziyaret ederek yaptığı toplantılar Ankara kulüpleriyle devam etti." +
                        "Toplantılarda TFF Başkan Vekili Nüket Küçükel Ezberci, Süper Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Müslüm Özmen ve 1. Lig Kulüplerinden Sorumlu Yönetim Kurulu Üyesi Talat Papatya da hazır bulundu." +
                        "TFF Başkanı Mehmet Büyükekşi ve yönetim kurulu üyelerinin Ankara'daki ilk durağı MKE Ankaragücü oldu. Ankaragücü Başkanı Faruk Koca ve yönetim kurulu üyelerinin ev sahipliğinde yapılan toplantıda kulübün Gençlik Geliştirme Programı Sorumlusu Ümit Turmuş da TFF heyetine bir sunum yaptı."),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    icon: Icons.remove,
                    iconSize: Dimensions.iconSize24,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white),
                BigText(
                  text: "12.88₺ " + "X " + "0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.fontSize26,
                ),
                AppIcon(
                    icon: Icons.add,
                    iconSize: Dimensions.iconSize24,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white),
              ],
            ),
          ),
          Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Icon(Icons.favorite,
                        color: AppColors.mainColor,
                        size: Dimensions.iconSize24 * 1.2)),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                  child: BigText(
                      text: " 12.88₺ | Sepete ekle", color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
