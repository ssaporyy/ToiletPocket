import 'package:ToiletPocket/models/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  List<Marker> getMarkers(List<Places> places){
    List<Marker> markers = <Marker>[];

    places.forEach((places){
      Marker marker = Marker( 
        markerId: MarkerId(places.name),
        draggable: false,
        icon: places.icon,
        infoWindow: InfoWindow(title: places.name, snippet: places.vicinity),
        position: LatLng(places.geometry.location.lat, places.geometry.location.lng)
      );

      markers.add(marker);
    });

  return markers;
  }

 
}