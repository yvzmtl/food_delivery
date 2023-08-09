import 'package:intl/intl.dart';

class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  static const BASE_URL = "http://mvs.bslmeiyu.com";
  // static const BASE_URL = "http://127.0.0.1:8000";
  // static const BASE_URL = "http://10.0.2.2:8000";
  // static const BASE_URL = "http://10.34.161.64:8000";
  static const POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  // static const DRINKS_PRODUCT_URI = "/api/v1/products/drinks";
  static const UPLOAD_URL = "/uploads/";

  static const String TOKEN = "DBToken";

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
