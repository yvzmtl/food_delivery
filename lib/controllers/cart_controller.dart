import 'package:flutter_food_delivery/data/repository/cart_repo.dart';
import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addCartItem(ProductsModel product, int quantity) {
    if (_items.containsKey(product.id!)) {
      //items listesinde ilgili id varsa true döner
      _items.update(product.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity, // ürün varsa sepetteki aynı ürünün üstüne ekliyoruz
            isExist: true,
            time: DateTime.now().toString());
      });
    } else {
      //items listesinde ilgili id yoksa false döner.
      _items.putIfAbsent(product.id!, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString());
      });
    }
  }

  bool isExistInCart(ProductsModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    else{
      return false;
    }
  }
}
