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
    ResponseModel responseModel;
    Response response = await authRepo.registration(signUpModel);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}