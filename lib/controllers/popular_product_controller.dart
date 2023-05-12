import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepository;

  PopularProductController({required this.popularProductRepository});

  List<ProductsModel> _popularProductList = [];
  List<ProductsModel> get popularProductList => _popularProductList;
  late CartController _cart;

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
        // print(_popularProductList);
        // print(_popularProductList.map((e) => e.name));
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
      print("Miktar1+ = " + _quantity.toString());
      // _quantity = _quantity + 1;
      _quantity = checkQuantity(_quantity + 1);
    } else {
      // _quantity = _quantity - 1;
      _quantity = checkQuantity(_quantity - 1);
      print("Miktar1- = " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar("Ürün Adeti", "Daha fazla azaltamazsınız !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems>0) {
            _quantity = -_inCartItems;
            return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar("Ürün Adeti", "Daha fazla ürün eklememezsiniz!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel product, CartController cart) {
    _quantity = 0;
   _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.isExistInCart(product);
    // print( "var ya da yok "+exist.toString());
    if (exist) {
      _inCartItems = cart.getQuantity(product);
    }
    print("sepetteki ürün miktarı = " +_inCartItems.toString());
  }

  void addItem(ProductsModel product) {
      _cart.addCartItem(product, _quantity);
      _quantity=0;
      _inCartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("İd = "+value.id.toString()+" miktarı = "+value.quantity.toString());
       });
   
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}
