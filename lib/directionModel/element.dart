
import 'package:ToiletPocket/directionModel/distance.dart';
import 'package:ToiletPocket/directionModel/duration.dart';

class Elements {
  final Distance distance;
  final Durations duration;
  final String status;

  Elements({this.distance, this.duration, this.status});

  factory Elements.fromJson(Map<String, dynamic> json) {
    return Elements(
        distance: new Distance.fromJson(json['distance']),
        duration: new Durations.fromJson(json['duration']),
        status: json['status']);
  }
}