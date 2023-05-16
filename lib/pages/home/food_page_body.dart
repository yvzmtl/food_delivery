import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/popular_product_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_product_controller.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/food_info.dart';
import 'package:flutter_food_delivery/widgets/icon_and_text_widget.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  //color: Colors.amber,
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(color: AppColors.mainColor);
        }),

        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: Size(Dimensions.width20, Dimensions.height10),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius5)),
            ),
          );
        }),

        /* SmoothPageIndicator(
          controller: pageController, // PageController
          count: 5,
          // forcing the indicator to use a specific direction
          //textDirection: TextDirection.rtl,
          effect: JumpingDotEffect(verticalOffset: 10),
        ) */

        //popular Text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Öneriler"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Yemek Önerileri"),
              ),
            ],
          ),
        ),
        //recommended food
        // yemek listesi ve resimler
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    var recommendedProductList =
                        recommendedProduct.recommendedProductList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                        // Get.to(() =>
                        //     RecommendedFoodDetail(recommendedProductList));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            //image
                            Container(
                              width: Dimensions.width120,
                              height: Dimensions.height120,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    //image: AssetImage("assets/image/food1.png"),
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedProductList.img!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            //text container
                            Expanded(
                              child: Container(
                                height: Dimensions.height100,
                                //width: Dimensions.width220,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20),
                                        topRight: Radius.circular(
                                            Dimensions.radius20))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                          text: recommendedProductList.name!),
                                      SizedBox(height: Dimensions.height10),
                                      BigText(
                                          text: recommendedProductList.description!,
                                              size: 12,
                                              color: Color(0xFFccc7c5),
                                              ),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          //SizedBox(width: 10),
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor),
                                          //SizedBox(width: 10),
                                          IconAndTextWidget(
                                              icon: Icons
                                                  .access_time_filled_rounded,
                                              text: "30min",
                                              iconColor: AppColors.iconColor2)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int position, ProductsModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (position == _currentPageValue.floor()) {
      var currentScale =
          1 - (_currentPageValue - position) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (position == _currentPageValue.floor() + 1) {
      var currentScale = _scaleFactor +
          (_currentPageValue - position + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (position == _currentPageValue.floor() - 1) {
      var currentScale =
          1 - (_currentPageValue - position) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Get.to(() => PopularFoodDetail());
              // Get.toNamed(RouteHelper.popularFood);
              Get.toNamed(RouteHelper.getPopularFood(position,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                //color: position.isEven ? Color(0xFF89dad0) : Color(0xFF5445b2),
                image: DecorationImage(
                    //image: AssetImage("assets/image/food1.png"),
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                      color: Colors.white, offset: Offset(5, 0), blurRadius: 5),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: FoodInfo(
                    text: popularProduct.name!, stars: popularProduct.stars!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
