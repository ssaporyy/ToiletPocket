import 'package:ToiletPocket/models/location.dart';
import 'viewport.dart';

//old
// class Geometry {
//   final Location location;

//   Geometry({this.location});

//   Geometry.fromJson(Map<dynamic,dynamic> parsedJson)
//     :location = Location.fromJson(parsedJson['location']);
// }

//new
class Geometry {
  final Location? location;
  final ViewPort? viewPort;
  Geometry({this.location, this.viewPort});

  factory Geometry.fromJson(Map<String, dynamic> json){
    return Geometry(
      location: Location.fromJson(json['location']),
      viewPort: ViewPort.fromJson(json['viewport'])
    );
  }
}