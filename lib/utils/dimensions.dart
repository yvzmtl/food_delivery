import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

//şuan kullanıdığım cihazın;
//mevcut yükseklik 781
// mevcut genişlik 392
// farklı cihazlarda boyut farklılıkları olabilir. O yüzden her cihazda aynı görüntüyü
// yakalabilmek için aynı oranı bulmak gerekiyor.

// bizim ana page yüksekliğini 320 olarak ayarlayınca istediğimiz görüntüye ulaşabiliyoruz
// bu cihazın tam olarak 2.44 katına denk geliyor.
// O yüzden 2.44 bölerek sayıyı tuturmuş oluyoruz.
//781/320 = 2.44
  static double pageView = screenHeight / 2.44;

// bizim pageContainer yüksekliğini 220 olarak ayarlayınca istediğimiz görüntüye ulaşabiliyoruz
// bu cihazın tam olarak 3.55 katına denk geliyor.
// O yüzden 3.55 bölerek sayıyı tuturmuş oluyoruz.
//781/220 = 3.55
  static double pageViewContainer = screenHeight / 3.55;

//aynı şekilde istediğimiz görüntüyü alabilmek için
// pagetextcontainer yüksekliğimizi 120 olarak ayarlıyoruz.
// bu nedenle 781/120 = 6.50 yapıyor.
  static double pageViewTextContainer = screenHeight / 6.50;

//781/10 = 78.1
//dinamik height padding ve margin
  static double height5 = screenHeight / 156.2;
  static double height10 = screenHeight / 78;
  static double height15 = screenHeight / 52;
  static double height20 = screenHeight / 39;
  static double height30 = screenHeight / 26;
  static double height45 = screenHeight / 17.35;
  static double height80 = screenHeight / 9.76;
  static double height100 = screenHeight / 7.81;
  static double height120 = screenHeight / 6.5;

  //dinamik width padding ve margin
  //  392/10
  static double width5 = screenWidth / 78.4;
  static double width10 = screenWidth / 39.2;
  static double width15 = screenWidth / 26.1;
  static double width20 = screenWidth / 19.6;
  static double width30 = screenWidth / 13;
  static double width45 = screenWidth / 8.71;
  static double width120 = screenWidth / 3.26;
  static double width220 = screenWidth / 1.78;

//fontsize
  static double fontSize15 = screenHeight / 52;
  static double fontSize20 = screenHeight / 39;
  static double fontSize24 = screenHeight / 32.54;
  static double fontSize26 = screenHeight / 30;

//radius
  static double radius5 = screenHeight / 156.2;
  static double radius15 = screenHeight / 52;
  static double radius20 = screenHeight / 39;
  static double radius30 = screenHeight / 26;

  //iconSize
  static double iconSize24 = screenHeight / 32.54;
  static double iconSize16 = screenHeight / 48.81;

  // popular food
  static double popularFoodImageSize = screenHeight / 2.23;

  // bottom height
  static double bottomHeight5 = screenHeight / 156.2;
  static double bottomHeight120 = screenHeight / 6.5;

  //splash-screen
   static double splashImg250 = screenHeight / 3.12;
}
