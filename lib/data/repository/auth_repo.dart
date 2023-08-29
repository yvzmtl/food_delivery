
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/models/signup_model.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});
  
   Future<Response> registration(SignUpModel signUpModel) async{
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpModel.toJson());
   }

    Future<Response> login(String email, String password) async{
    return await apiClient.postData(AppConstants.LOGIN_URI, {"email":email, "password":password});
   }

   Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
   }

  //kullanıcı login mi değil mi
   bool userLoggedIn(){
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
   }

    Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
   }

   Future<void> saveUserEmailAndPassword(String email,String password) async {
    try {
      await sharedPreferences.setString(AppConstants.EMAIL, email);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
   }

   bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.EMAIL);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
   }
}