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
     //sharedPreferences.remove(AppConstants.CART_LIST);
     //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    cart = [];
    var time = DateTime.now().toString();

    // nesneleri stringe dönüştürmek lazım çünkü sharedprefences sadece string kabul eder.
    cartList.forEach((element) {
      element.time = time;
       return cart.add(jsonEncode(element));
    });

     sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
     //getCartList();
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

  List<CartModel> getCartHistoryList(){
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      //cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory=[];
    cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("history list = "+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("History cart uzunluğu = "+getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++) {
       print("Sipariş zamanı = "+getCartHistoryList()[j].time.toString());
    }
  }
  
  void removeCart() {
    cart=[];
     sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
