import 'package:ToiletPocket/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Applicationbloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();

  Position currentLocation;

  Applicationbloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}