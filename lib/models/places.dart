import 'package:ToiletPocket/models/geometry.dart';
import 'package:ToiletPocket/models/photo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Places {
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;
  final Geometry geometry;
  final BitmapDescriptor icon;
  //new
  // final String id;
  final List<Photo> photos;
  final String placeId;
  final String reference;
  final String scope;
  final List<String> types;
  final int userRatingsTotal;
  //
  // List<OpeningHour> openingHours;
  // OpeningHours openingHours;


  Places({
    this.geometry,
    this.name,
    this.rating,
    this.userRatingCount,
    this.vicinity,
    this.icon,
    this.photos, this.placeId, this.reference, this.scope, this.types, this.userRatingsTotal,/*this.openingHours,    this.openingHours,*/

  });

  Places.fromJson(
    Map<dynamic, dynamic> json,
    BitmapDescriptor icon
  )   : name = json['name'],
        rating = (json['rating'] != null)
            ? json['rating'].toDouble()
            : null,
        userRatingCount = (json['user_ratings_total'] != null)
            ? json['user_ratings_total']
            : null,
        vicinity = json['vicinity'],
        geometry = Geometry.fromJson(json['geometry']),
  //new --------------------------------------
    photos= json['photos'] != null
          ? json['photos'].map<Photo>((i) => Photo.fromJson(i)).toList()
          : [],
      placeId= json['place_id'],
      reference= json['reference'],
      scope= json['scope'],
      types= List<String>.from(json['types']),
      userRatingsTotal= json['user_ratings_total'],
  //new --------------------------------------
    // openingHours = json['opening_hours'] != null
    //     ? new OpeningHours.fromJson(json['opening_hours'])
    //     : null,


  //old
  icon=icon;


  // Place.fromJson(
  //   Map<dynamic, dynamic> parsedJson,
  //   BitmapDescriptor icon
  // )   : name = parsedJson['name'],
  //       rating = (parsedJson['rating'] != null)
  //           ? parsedJson['rating'].toDouble()
  //           : null,
  //       userRatingCount = (parsedJson['user_ratings_total'] != null)
  //           ? parsedJson['user_ratings_total']
  //           : null,
  //       vicinity = parsedJson['vicinity'],
  //       geometry = Geometry.fromJson(parsedJson['geometry']),
  // //new
  //   photos: json['photos'] != null
  //         ? json['photos'].map<Photo>((i) => Photo.fromJson(i)).toList()
  //         : [],
  //     placeId: json['place_id'],
  //     rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
  //     reference: json['reference'],
  //     scope: json['scope'],
  //     types: List<String>.from(json['types']),
  //     userRatingsTotal: json['user_ratings_total'],


  // //old
  // icon=icon;

  

}

// //new
// class Place {
//   final Geometry geometry;
//   final String name;
//   final String vicinity;

//   Place({this.geometry,this.name,this.vicinity});

//   factory Place.fromJson(Map<String,dynamic> json){
//     return Place(
//         geometry:  Geometry.fromJson(json['geometry']),
//         name: json['formatted_address'],
//         vicinity: json['vicinity'],
        
//     );
//   }
// }
