
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
    41.0082, 28.9784), 
    zoom: 17);
    late LatLng _initialPosition;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged&&Get.find<UserController>().userModel==null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}