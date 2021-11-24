import 'dart:convert';
import 'dart:async' show Future;
import 'package:ToiletPocket/directionModel/element.dart';
import 'package:flutter/services.dart' show rootBundle;

class DistanceMatrix {
  final List<String> destinations;
  final List<String> origins;
  final List<Elements> elements;
  final String status;

  DistanceMatrix({this.destinations, this.origins, this.elements, this.status});

  factory DistanceMatrix.fromJson(Map<String, dynamic> json) {
    var destinationsJson = json['destination_addresses'];
    var originsJson = json['origin_addresses'];
    var rowsJson = json['rows'][0]['elements'] as List;

    return DistanceMatrix(
        destinations: destinationsJson.cast<String>(),
        origins: originsJson.cast<String>(),
        elements: rowsJson.map((i) => new Elements.fromJson(i)).toList(),
        status: json['status']);
  }
  static Future<DistanceMatrix> loadData() async {
    DistanceMatrix distanceMatrix;
    try{
          String jsonData = await rootBundle.loadString('assets/data.json');
          // String jsonData = await rootBundle.loadString('assets/google-services.json');
    distanceMatrix = new DistanceMatrix.fromJson(json.decode(jsonData));
    } catch (e){
      print(e);
    }
    return distanceMatrix;
  }
}





