import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
// final Geolocator geo = Geolocator();
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

    Stream<Position> getCurrentLocation(){
    // var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return GeolocatorPlatform.instance.getPositionStream(desiredAccuracy: LocationAccuracy.high,distanceFilter: 10);
  }

  // Stream<Position> getCurrentLocation(){
  //   var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  //   return geo.getPositionStream(locationOptions);
  // }


  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
