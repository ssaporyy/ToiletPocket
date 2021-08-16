import 'package:ToiletPocket/data/place_response.dart';
import 'package:ToiletPocket/data/result.dart';
import 'package:ToiletPocket/models/place_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ToiletPocket/models/place.dart';
import 'dart:convert' as convert;

class PlacesService {
  // final key = 'YOUR_KEY';
  final key = 'AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //ช่องค้นหา
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=establishment&components=country:th&language=th&key=$key';
    // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    // 'https://maps.googleapis.com/maps/api/place/textsearch/json?input=toilets+in+$search&key=$key';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

//เสิร์จขึ้นที่เดียว
  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

//เสิร์จขึ้นหลายที่
  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$_API_KEY&location=$latitude,$longitude&radius=1500&keyword=${widget.keyword}';

        //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$key&location=$lat,$lng&radius=1500&keyword=$placeType';

        // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$key&location=$lat,$lng&radius=1500&keyword=$placeType';
        // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$key&location=$lat,$lng&radius=1500&keyword=$placeType';
        //ต้นฉบับ
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
        // 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=$key=$lat,$lng&radius=1500&keyword=$placeType';


    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
