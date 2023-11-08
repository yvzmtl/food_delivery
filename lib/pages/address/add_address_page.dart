
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_app_bar.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/controllers/user_controller.dart';
import 'package:flutter_food_delivery/models/address_model.dart';
import 'package:flutter_food_delivery/pages/address/pick_address_map.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_text_field.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
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
  final TextEditingController _contactPersonPhone = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
    41.0082, 28.9784), 
    zoom: 17);

  late LatLng _initialPosition = LatLng(41.0082, 28.9784);

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel==null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage()=="") {
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
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
    return Scaffold(
      appBar: CustomAppBar(title: "Adres"),
        body: GetBuilder<UserController>(
          builder: (userController) {
            if (userController.userModel != null && _contactPersonName.text.isEmpty) {
              _contactPersonName.text = '${userController.userModel?.name}';
              _contactPersonPhone.text = '${userController.userModel?.phone}';
            }
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text = Get.find<LocationController>().getUserAddress().address;
            }
            return GetBuilder<LocationController>(
          builder: (locationController) {
            _addressController.text = '${locationController.placemark.name??''}'
            '${locationController.placemark.locality??''}'
            '${locationController.placemark.postalCode??''}'
            '${locationController.placemark.country??''}';
            print("add_address_page benim adresim = "+_addressController.text);

            return SingleChildScrollView(
              child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimensions.height10 * 14,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            top: Dimensions.height10 / 2, left: Dimensions.width5, right: Dimensions.width5),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius5),
                            border: Border.all(width: 2, color: AppColors.mainColor)),
                        child: Stack(
                          children: [
                          GoogleMap(initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromSignup: false,
                                  fromAddress: true,
                                  googleMapController: locationController.mapController,
                                )
                              );
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            myLocationEnabled: true,
                            mapToolbarEnabled: false,
                            onCameraIdle: () {
                              locationController.updatePosition(_cameraPosition,true);
                            },
                            onCameraMove: ((position) =>_cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                              if (Get.find<LocationController>().addressList.isEmpty) {
                                //locationController.getCurrentLocation(true, mapController:controller);
                              }
                              },
                            )
                ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.width20,top:Dimensions.height20),
                        child: SizedBox(
                            height: Dimensions.height10 * 5,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locationController.setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10),
                                    margin: EdgeInsets.only(right: Dimensions.width10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                      color: Theme.of(context).cardColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5
                                        )
                                      ]
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                                          color: locationController.addressTypeIndex==index?
                                              AppColors.mainColor:Theme.of(context).disabledColor,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
            
                      // SİPARİŞ ADRESİ
                      SizedBox(height: Dimensions.height20),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: BigText(text: "Sipariş Adresi"),
                      ),
                      SizedBox(height: Dimensions.height10),
                      AppTextWidget(
                          textController: _addressController,
                          hintText: "Adres",
                          icon: Icons.map),
            
                      // AD SOYAD    
                      SizedBox(height: Dimensions.height20),
                      Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10 * 2),
                          child: BigText(text: "Ad Soyad")),
                      SizedBox(height: Dimensions.height10),
                      AppTextWidget(
                          textController: _contactPersonName,
                          hintText: "Ad Soyad",
                          icon: Icons.person),
                      
                      // TELEFON
                      SizedBox(height: Dimensions.height20),
                      Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10 * 2),
                          child: BigText(text: "Telefon")),
                      SizedBox(height: Dimensions.height10),
                      AppTextWidget(
                          textController: _contactPersonPhone,
                          hintText: "Telefon",
                          icon: Icons.phone),
                    ],
                  ),
            );
              },
            );
          },
        ),
        bottomNavigationBar:
            GetBuilder<LocationController>(builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Container(
                height: Dimensions.height10*14,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                      topLeft: Radius.circular(Dimensions.radius20 * 2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonPhone.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString());

                          locationController.addAddress(_addressModel).then((response){
                            if (response.isSuccess) {
                              // Get.back();
                              Get.toNamed(RouteHelper.getInitial());
                              Get.snackbar("Adres", "Adres başarıyla eklendi");
                            } else {
                              Get.snackbar("Adres", "Adres kayıt edilemedi");
                            }
                          });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: BigText(
                            text:
                                "Adresi Kaydet",
                            color: Colors.white,size: Dimensions.fontSize26,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        })
    );
  }
}