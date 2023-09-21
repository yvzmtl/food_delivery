import 'package:flutter_food_delivery/data/repository/user_repo.dart';
import 'package:flutter_food_delivery/models/response_model.dart';
import 'package:flutter_food_delivery/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;

  UserController({required this.userRepo});

  UserModel? _userModel;
  bool _isLoading = false; 

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async{

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("user controller user body = "+response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "başarılı");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print("user controller response status text = "+response.statusText.toString());
    }
    update();
    return responseModel;
  }
}