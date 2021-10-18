// import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:ToiletPocket/show_toiletDetail_review/toiletdetail.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:ToiletPocket/models/result.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
class MarkerService {
  final placesService = PlacesService();
  // List<Marker> getMarkers(List<Result> places){
  List<Marker> getMarkers(List<Places> places){
    var markers = <Marker>[];

    places.forEach((place){
      // final _place = ModalRoute.of(context)?.settings.arguments as Places;
      Marker marker = Marker( 
        markerId: MarkerId(place.name!),
        draggable: false,
        icon: place.icon!,
        infoWindow: InfoWindow(
          title: place.name, 
          snippet: place.vicinity,
          anchor: Offset(1,1),
          ),
        position: LatLng(place.geometry!.location!.lat!, place.geometry!.location!.lng!),
        //edit this
        // onTap: () async{
        //   final placeDetail =await placesService.getPlaceDetail(_place.placeId);
        //   print("hello ------------------------- ${_place.placeId}");
          // print('test');
          // Navigator.pushNamed(context, '/third',
          // arguments: {
          //   'places': _place,
          //   'places_detail':placeDetail,
          // }
          // );
          // Navigator.pushReplacement(context,
          //               MaterialPageRoute(builder: (context) {
          //             return ToiletDetail();
          //           }));
        // }
      );
      

      markers.add(marker);
    });

  return markers;
  }

 
}