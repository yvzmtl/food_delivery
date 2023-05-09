import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepository;

  PopularProductController({required this.popularProductRepository});

  List<ProductsModel> _popularProductList = [];
  List<ProductsModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepository.getPopularProductList();

    try {
      if (response.statusCode == 200) {
        print("sunucudan ürünler başarıyla geldi.");
        // burda yeniden boş liste atıyoruz. Çünkü bu işlem birden fazla kez
        //çalıştırabilir. önceki ürünleri tekrar etmemesi için listeyi sıfırlıyoruz.
        _popularProductList = [];
        _popularProductList.addAll(Product.fromJson(response.body).products);
        print(_popularProductList);
        print(_popularProductList.map((e) => e.name));
        _isLoaded = true;
        update();
      } else {
        print("Hata oluştu ve hata = " + response.body);
      }
    } catch (e) {
      print("Controller da hata =  " + e.toString());
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      print("Miktar = " + _quantity.toString());
      _quantity = _quantity + 1;
      // _quantity = checkQuantity(_quantity + 1);
    } else {
      print("Miktar = " + _quantity.toString());
      _quantity = _quantity - 1;
      // _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar("Ürün Adeti", "Daha fazla azaltamazsınız !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if (quantity > 20) {
      Get.snackbar("Ürün Adeti", "Daha fazla ürün eklememezsiniz!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct() {
    _quantity = 0;
  }
}
