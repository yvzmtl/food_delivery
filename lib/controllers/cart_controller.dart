import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/data/repository/cart_repo.dart';
import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  
  //sadece storage ve sharedpreferences için
  List<CartModel> storageItems=[];
  void addCartItem(ProductsModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      //items listesinde ilgili id varsa true döner
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity!+quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity, // ürün varsa sepetteki aynı ürünün üstüne ekliyoruz
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity<=0) {
        _items.remove(product.id);
      }
    } else {
      //items listesinde ilgili id yoksa false döner.
      if (quantity>0) {
        _items.putIfAbsent(product.id!, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product);
      });
      }
      else {
      Get.snackbar("Ürün Adeti", "En az 1 ürün eklemelisiniz !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool isExistInCart(ProductsModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    else{
      return false;
    }
  }

  int getQuantity(ProductsModel product){
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) { 
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    } 
      return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) { 
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{
    
    var total = 0;
    _items.forEach((key, value) { 
      total += value.quantity!*value.price!;
    });
    
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }
  
  set setCart(List<CartModel> items){
    storageItems = items;
    print("Cart items uzunluğu = "+storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToCartHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  
  void clear() {
    _items= {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

}
