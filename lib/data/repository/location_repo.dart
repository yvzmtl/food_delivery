
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/models/address_model.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
    '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  } 

  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, userAddress);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String searchText) async {
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$searchText');
  }
  
  Future<Response> setLocation(String placeID) async {
    return await apiClient.getData('${AppConstants.PALCE_DETAILS_URI}?placeid=$placeID');
  }
}