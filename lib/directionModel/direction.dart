import 'dart:convert';
import 'dart:async' show Future;
import 'package:ToiletPocket/directionModel/element.dart';
import 'package:flutter/services.dart' show rootBundle;

class DistanceMatrix {
  final List<String> destinations;
  final List<String> origins;
  final List<Elements> elements;
  final String status;

  DistanceMatrix({
    this.destinations,
    this.origins,
    this.elements,
    this.status,
  });

  factory DistanceMatrix.fromJson(Map<String, dynamic> json) {
    var destinationsJson = json['destination_addresses'] as List;
    var originsJson = json['origin_addresses'] as List;
    var rowsJson = json['rows'][0]['elements'] as List;

    return DistanceMatrix(
        destinations: destinationsJson.map((e) => e as String).toList(),
        origins: originsJson.map((e) => e as String).toList(),
        elements: rowsJson.map((i) => new Elements.fromJson(i)).toList(),
        status: json['status']);
  }
  static Future<DistanceMatrix> loadData() async {
    DistanceMatrix distanceMatrix;
    try {
      String jsonData = await rootBundle.loadString('assets/data.json');
      distanceMatrix = new DistanceMatrix.fromJson(json.decode(jsonData));
    } catch (e) {
      print(e);
    }
    return distanceMatrix;
  }
}
