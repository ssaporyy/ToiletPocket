import 'dart:async';

import 'package:ToiletPocket/models/photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ToiletPocket/models/geometry.dart';
import 'package:ToiletPocket/models/location.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/models/place_search.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/services/geolocator_service.dart';
import 'package:ToiletPocket/services/marker_service.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeoLocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  Position currentLocation;
  List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation =
      StreamController<Place>.broadcast();
  // StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds =
      StreamController<LatLngBounds>.broadcast();
  // StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place selectedLocationStatic;
  String placeType;
  // List<Places> placeResults;
  List<Place> placeResults;
  List<Marker> markers = <Marker>[];
  //new
  List<Places> places;
  List<Photo> photos;

  List<String> urlImg = [];

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getLocation();
    // currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: null,
      geometry: Geometry(
        location: Location(
            lat: currentLocation.latitude, lng: currentLocation.longitude),
      ),
    );
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    //new
    var markers =
        (places != null) ? markerService.getMarkers(places) : <Marker>[];
    //
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  // setSelectedLocation(String placeId) async {
  //   var sLocation = await placesService.getPlace(placeId);
  //   selectedLocation.add(sLocation);
  //   selectedLocationStatic = sLocation;
  //   searchResults = null;
  //   notifyListeners();
  // }

  clearSelectedLocation() {
    selectedLocation.add(null);
    selectedLocationStatic = null;
    searchResults = null;
    placeType = null;
    notifyListeners();
  }

  getImages(url) {
    this.urlImg = url;
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}
