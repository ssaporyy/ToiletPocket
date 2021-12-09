import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

    Stream<Position> getCurrentLocation(){
    return GeolocatorPlatform.instance.getPositionStream(desiredAccuracy: LocationAccuracy.high,distanceFilter: 10);
  }



  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
