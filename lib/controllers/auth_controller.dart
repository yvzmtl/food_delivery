import 'dart:convert';

import 'package:flutter_food_delivery/data/repository/auth_repo.dart';
import 'package:flutter_food_delivery/models/response_model.dart';
import 'package:flutter_food_delivery/models/signup_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpModel signUpModel) async{
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"].toString()); 
      print("Token = "+response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"].toString());
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


    Future<ResponseModel> login(String email, String password) async{
    print("Token geldi");
    print("Token başlangıç = "+jsonEncode(authRepo.getUserToken().toString()));
    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Token bitti");
      authRepo.saveUserToken(response.body["token"].toString());
      print("Token = "+response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"].toString());
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserPhoneAndPassword(String phone,String password) {
    authRepo.saveUserPhoneAndPassword(phone, password);
  }

   bool userLoggedIn(){
    return  authRepo.userLoggedIn();
   }
}