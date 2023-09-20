
import 'package:flutter_food_delivery/data/repository/location_repo.dart';
import 'package:flutter_food_delivery/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList=[]; 
  List<AddressModel> get addressList => _addressList; 
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["ev","ofis","diğer"];
  int _addressTypeIndex = 0;
  late Map<String,dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            longitude: position.target.longitude, 
            latitude: position.target.latitude, 
            timestamp: DateTime.now(), 
            accuracy: 1, altitude: 1, 
            heading: 1, 
            speed: 1, 
            speedAccuracy: 1);
        }else{
          _pickPosition = Position(
            longitude: position.target.longitude, 
            latitude: position.target.latitude, 
            timestamp: DateTime.now(), 
            accuracy: 1, altitude: 1, 
            heading: 1, 
            speed: 1, 
            speedAccuracy: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude)
          );
          fromAddress?_placemark=Placemark(name: _address): _pickPlacemark=Placemark(name: _address);
        }
      } catch (e) {
        print("location controller catch hatası"+e.toString());
      }
    }
  }
  
  // Future<String> getAddressfromGeocode(LatLng latLng) async {
  //   String _address = "Bilinmeyen Lokasyon bulundu";
  //   Response response = await locationRepo.getAddressfromGeocode(latLng);
  //   if (response.body["status"] == 'OK') {
  //     _address = response.body["results"][0]['formatted_address'].toString();
  //     print("location controller adresi yazdır = "+_address);
  //   }else{
  //     print("location controller = Google api ile bağlantı kurulamadı");
  //   }
  //   return _address;
  // }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String address = 'Unknown location found';
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latlng.latitude,
        latlng.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        // Get the detailed address components
        String street = placemark.street ?? '';
        String subThoroughfare = placemark.subThoroughfare ?? '';
        String locality = placemark.locality ?? '';
        String administrativeArea = placemark.administrativeArea ?? '';
        String country = placemark.country ?? '';

        // Build the full address string
        address = '$street, $subThoroughfare, $locality, $administrativeArea, $country';
        print("location controller adresi yazdır = "+address);
      } else {
        print('Error getting geocode');
      }
    } catch (e) {
      print('Error getting geocode: $e');
    }

    return address;
  }
}