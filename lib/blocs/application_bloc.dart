import 'package:ToiletPocket/models/place_search.dart';
import 'package:ToiletPocket/services/%C2%A0geolocator_service.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  //variables
  Position currentLocation;
  List<PlaceSearch> searchResults;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async{
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

}