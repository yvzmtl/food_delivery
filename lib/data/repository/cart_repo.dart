import 'dart:convert';

import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({ required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartList){
   
    cart = [];
    // nesneleri stringe dönüştürmek lazım çünkü sharedprefences sadece string kabul eder.
    cartList.forEach((element) =>
       cart.add(jsonEncode(element)));

     sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
     getCartList();
     //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("getCartList içeriği = "+carts.toString());
    }
    List<CartModel> cartList=[];
    carts.forEach((element) =>
      cartList.add(CartModel.fromJson(jsonDecode(element))));
       //print("cartlist uzunluğu ="+cartList.length.toString());
    return cartList;
  }

  void addToCartHistoryList(){
    for (int i = 0; i < cart.length; i++) {
      print("history list = "+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }
  
  void removeCart() {
     sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
