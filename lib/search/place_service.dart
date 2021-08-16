import 'dart:convert';
import 'dart:io';

import 'package:ToiletPocket/models/place_search.dart';
import 'package:http/http.dart' /*as http*/;

import 'dart:convert' as convert;

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno';
  static final String iosKey = 'AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno';
  // static final String androidKey = 'YOUR_API_KEY_HERE';
  // static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  //https://maps.googleapis.com/maps/api/place/autocomplete/json?input=bangkok&types=(cities)&language=TH&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno
  //https://maps.googleapis.com/maps/api/place/textsearch/json?query=toilet+in+Bangkok&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno
  //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=13.736717,%20100.523186&rankby=distance&type=university&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno


  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:TH&key=$apiKey&sessiontoken=$sessionToken';
    // 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:th&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
