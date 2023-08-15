
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/models/signup_model.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});
  
   registration(SignUpModel signUpModel){
    apiClient.postData(AppConstants.REGISTRATION_URI, signUpModel.toJson());
   }
}