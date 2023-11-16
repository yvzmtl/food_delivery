
import 'package:firebase_messaging/firebase_messaging.dart';
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

   Future<Response> updateToken() async{
    String? _deviceToken;
    if (GetPlatform.isIOS && !GetPlatform.isWeb) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
        print("My token 1 = "+_deviceToken!);
      }
    } else {
        _deviceToken = await _saveDeviceToken();
        print("My token 2 = "+_deviceToken!);
    }
    if (!GetPlatform.isWeb) {
      //FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    }

    return await apiClient.postData(AppConstants.TOKEN_URI, {"_method" : "put", "cm_firebase_token" : _deviceToken});
   }

   Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        FirebaseMessaging.instance.requestPermission();
        _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print("Token getirilemedi");
        print(e.toString());
      }
    }

    if (_deviceToken != null) {
      print("---------Device Token ----------- "+ _deviceToken);
    }
    return _deviceToken;
   }
}