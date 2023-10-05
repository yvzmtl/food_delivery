import 'package:intl/intl.dart';

class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  // static const BASE_URL = "http://mvs.bslmeiyu.com";
  // static const BASE_URL = "http://127.0.0.1:8000";
  static const BASE_URL = "http://10.0.2.2:8000";
  static const BASE_URL2 = "http://127.0.0.1:8000";
  // static const BASE_URL = "http://10.34.161.64:8000";
  static const POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  // static const DRINKS_PRODUCT_URI = "/api/v1/products/drinks";
  static const UPLOAD_URL = "/uploads/";
  

  //auth
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const USER_ADDRESS = "user-address";
  static const ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const GEOCODE_URI = "/api/v1/config/geocode-api";


  static const String TOKEN = "";
  static const String EMAIL = "";
  static const String PASSWORD = "";

  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";


  static String datetimeFormat(String date){
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat("dd-MM-yyyy hh:mm");
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
    
  }
}
