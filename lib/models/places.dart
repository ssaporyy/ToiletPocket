import 'package:ToiletPocket/models/geometry.dart';
import 'package:ToiletPocket/models/photo.dart';
import 'package:ToiletPocket/models/reviews.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'opening_hours.dart';

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
  final OpeningHours openingHours;
  final List<Reviews> reviews;

  Places({
    this.geometry,
    this.name,
    this.rating,
    this.userRatingCount,
    this.vicinity,
    this.icon,
    this.openingHours,
    this.photos,
    this.placeId,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    //
    this.reviews,
  });

  Places.fromJson(Map<String, dynamic> json, BitmapDescriptor icon)
      : name = json['name'],
        rating = (json['rating'] != null) ? json['rating'].toDouble() : null,
        userRatingCount = (json['user_ratings_total'] != null)
            ? json['user_ratings_total']
            : null,
        vicinity = json['vicinity'],
        geometry = Geometry.fromJson(json['geometry']),
        photos = json['photos'] != null
            ? json['photos'].map<Photo>((i) => Photo.fromJson(i)).toList()
            : [],
        placeId = json['place_id'],
        reference = json['reference'],
        scope = json['scope'],
        types = List<String>.from(json['types']),
        userRatingsTotal = json['user_ratings_total'],
        openingHours = json['opening_hours'] != null
            ? OpeningHours.fromJson(
                json['opening_hours'] as Map<String, dynamic>)
            : null,
        //
        reviews = json['reviews'] != null
            ? json['reviews'].map<Reviews>((i) => Reviews.fromJson(i)).toList()
            : [],
        //old
        icon = icon;
}
