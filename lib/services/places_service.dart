
import 'package:ToiletPocket/directionModel/direction.dart';
import 'package:ToiletPocket/distanceModel/distanceModel.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/models/place_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno';

  Future<List<Places>> getPlaces(
      double lat, double lng, BitmapDescriptor icon) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=establishment&keyword=toilets&rankby=distance&key=$key'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Places.fromJson(place, icon)).toList();
  }


  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //ช่องค้นหา
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&components=country:th&language=th&key=$key';
   
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }


  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<Places> getPlaceDetail(String placeId) async {
    final _url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    final response = await http.get(Uri.parse(_url));
    final json = convert.jsonDecode(response.body);
    final jsonResult = json['result'] as Map<String, dynamic>;
    return Places.fromJson(jsonResult, null);
  }

//เสิร์จ

  Future<List<Place>> getPlaceSs(
      double lat, double lng, String placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

  Future<DistanceMatrix> getDirection(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) async {
    final _url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$lat2,$lng2&language=th-TH&mode=driving&origins=$lat1,$lng1&key=$key';
    final response = await http.get(Uri.parse(_url));
    print('===========> DIRECTION <==========');
    print('lat1: $lat1, lat2: $lat2, lng1: $lng1, lng2: $lng2');
    print('status code: ${response.statusCode}');
    print('response: ${response.body}');
    final json = convert.jsonDecode(response.body);
    return DistanceMatrix.fromJson(json);
  }


  Future<DistanceModel> getDirectionModel(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) async {
    final _url =
        'https://maps.googleapis.com/maps/api/directions/json?destination=$lat2,$lng2&origin=$lat1,$lng1&language=th-TH&mode=DRIVING&key=$key';
    final response = await http.get(Uri.parse(_url));
    print('===========> DIRECTION MODEL <==========');
    print('lat1: $lat1, lat2: $lat2, lng1: $lng1, lng2: $lng2');
    print('status code: ${response.statusCode}');
    print('response: ${response.body}');
    final json = convert.jsonDecode(response.body);
    return DistanceModel.fromJson(json);
  }
}
