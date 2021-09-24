import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ToiletPocket/models/geometry.dart';
import 'package:ToiletPocket/models/photo.dart';

class PlacesTest {
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

  PlacesTest({
    this.name,
    this.rating,
    this.userRatingCount,
    this.vicinity,
    this.geometry,
    this.icon,
    this.photos,
    this.placeId,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
  });
  //
  // List<OpeningHour> openingHours;
  // OpeningHours openingHours;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'userRatingCount': userRatingCount,
      'vicinity': vicinity,
      'geometry': geometry.toMap(),
      'icon': icon.toMap(),
      'photos': photos?.map((x) => x.toMap())?.toList(),
      'placeId': placeId,
      'reference': reference,
      'scope': scope,
      'types': types,
      'userRatingsTotal': userRatingsTotal,
    };
  }

  factory PlacesTest.fromMap(Map<String, dynamic> map) {
    return PlacesTest(
      name: map['name'],
      rating: map['rating'],
      userRatingCount: map['userRatingCount'],
      vicinity: map['vicinity'],
      geometry: Geometry.fromMap(map['geometry']),
      icon: BitmapDescriptor.fromMap(map['icon']),
      photos: List<Photo>.from(map['photos']?.map((x) => Photo.fromMap(x))),
      placeId: map['placeId'],
      reference: map['reference'],
      scope: map['scope'],
      types: List<String>.from(map['types']),
      userRatingsTotal: map['userRatingsTotal'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlacesTest.fromJson(String source) => PlacesTest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlacesTest(name: $name, rating: $rating, userRatingCount: $userRatingCount, vicinity: $vicinity, geometry: $geometry, icon: $icon, photos: $photos, placeId: $placeId, reference: $reference, scope: $scope, types: $types, userRatingsTotal: $userRatingsTotal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PlacesTest &&
      other.name == name &&
      other.rating == rating &&
      other.userRatingCount == userRatingCount &&
      other.vicinity == vicinity &&
      other.geometry == geometry &&
      other.icon == icon &&
      listEquals(other.photos, photos) &&
      other.placeId == placeId &&
      other.reference == reference &&
      other.scope == scope &&
      listEquals(other.types, types) &&
      other.userRatingsTotal == userRatingsTotal;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      rating.hashCode ^
      userRatingCount.hashCode ^
      vicinity.hashCode ^
      geometry.hashCode ^
      icon.hashCode ^
      photos.hashCode ^
      placeId.hashCode ^
      reference.hashCode ^
      scope.hashCode ^
      types.hashCode ^
      userRatingsTotal.hashCode;
  }
}
