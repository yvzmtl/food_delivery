import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_button.dart';
import 'package:flutter_food_delivery/controllers/location_controller.dart';
import 'package:flutter_food_delivery/models/address_model.dart';
import 'package:flutter_food_delivery/routes/route.helper.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {super.key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(41.0082, 28.9784);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["latitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
              child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(children: [
                GoogleMap(
                  initialCameraPosition:CameraPosition(target: _initialPosition, zoom: 17),
                  // myLocationEnabled: true,
                  // myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>().updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                  child: !locationController.loading?Image.asset("assets/image/pick_marker.png",
                  height: Dimensions.height30,width: Dimensions.width10*3,)
                  : CircularProgressIndicator()
                ),

                Positioned(
                  top: Dimensions.height15*3,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: Dimensions.height10*5,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20/2)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,size: 25,color: AppColors.yellowColor),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlacemark.name??''}',
                            style: TextStyle(color: Colors.white,fontSize: Dimensions.fontSize15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: Dimensions.bottomHeight5*20,
                  left: Dimensions.width20*2,
                  width: Dimensions.width20*15,
                  child: CustomButton(
                    buttonText: "Seçilen Adres",
                    onPressed: locationController.loading?(){
                      print("değer boş olmamalı");}
                      :(){
                      if (locationController.pickPosition.latitude!=0 && 
                          locationController.pickPlacemark.name!=null) {
                        if (widget.fromAddress) {
                          if (widget.googleMapController!=null) {
                            print("Butona şimdi tıklayabilirsiniz");
                            widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(target: LatLng(
                                locationController.pickPosition.latitude,
                                locationController.pickPosition.longitude))));
                            locationController.setAddressData();
                          }
                          Get.back();
                          // locationController.saveUserAddress(
                          //   AddressModel(
                          //     addressType: "home", 
                          //     address: locationController.pickPlacemark.name,
                          //     latitude: locationController.pickPosition.latitude.toString(),
                          //     longitude: locationController.pickPosition.longitude.toString(),),);
                          // Get.toNamed(RouteHelper.getAddressPage());
                        }
                      }
                    },
                    ),
                  ),
              ]),
            ),
          )),
        );
      },
    );
  }
}
