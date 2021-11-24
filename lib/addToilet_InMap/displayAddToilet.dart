import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayAddToilets extends StatefulWidget {
  const DisplayAddToilets({Key key}) : super(key: key);

  @override
  _DisplayAddToiletsState createState() => _DisplayAddToiletsState();
}

class _DisplayAddToiletsState extends State<DisplayAddToilets> {
  CameraPosition position;

  BitmapDescriptor customIcon;

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(40, 40)), 'images/flush.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AddToilets")),
      body: Container(
        child: Row(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("AddToilets")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((document) {
                        print('+++++++++++++++++'
                            '${document['currentlocationLat']}'
                            "+++++++++"
                            '${document['currentlocationLong']}');
                        //images/flush.png
                        List<Marker> _markers = [];

                        _markers.add(Marker(
                            markerId: MarkerId('addToilet'),
                            position: LatLng(document['currentlocationLat'],
                                document['currentlocationLong']),
                            infoWindow: InfoWindow(title: document['name'])));

                        Marker userAddMarker() {
                          return Marker(
                              markerId: MarkerId('addToilet'),
                              position: LatLng(document['currentlocationLat'],
                                  document['currentlocationLong']),
                              icon: customIcon,
                              // BitmapDescriptor.defaultMarkerWithHue(150.0),
                              infoWindow: InfoWindow(title: document['name']));
                        }

                        Set<Marker> mySet() {
                          return <Marker>[userAddMarker()].toSet();
                        }

                        return Container(
                          height: 250,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(document['currentlocationLat'],
                                  document['currentlocationLong']),
                              // target: LatLng(37.4219825, -122.0840241),
                              zoom: 16.0,
                              tilt: 50.0,
                              // bearing: 30,
                            ),
                            mapType: MapType.normal,
                            onMapCreated: (controller) {},
                            markers: Set<Marker>.of(_markers),
                            // markers: mySet(),
                          ),
                          // ListTile(
                          //   leading:  Container(
                          //   color: Colors.grey,
                          //   height: 250,
                          //   child: GoogleMap(
                          //     initialCameraPosition: CameraPosition(
                          //       target: LatLng(37.4219825,-122.0840241),
                          //       zoom: 16.0,
                          //       tilt: 50.0,
                          //       // bearing: 30,
                          //     ),
                          //     mapType: MapType.normal,
                          //     onMapCreated: (controller) {},
                          //   )),

                          // ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// const LatLng SOURCE_LOCATION = LatLng(13.652720, 100.493635);
// const LatLng DEST_LOCATION = LatLng(13.6640896, 100.4357021);

// class Direction extends StatefulWidget {
//   @override
//   _DirectionState createState() => _DirectionState();
// }

// class _DirectionState extends State<Direction> {
//   Completer<GoogleMapController> mapController = Completer();

//   Set<Marker> _markers = Set<Marker>();
//   LatLng currentLocation;
//   LatLng destinationLocation;

//   Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints;

//   @override
//   void initState() {
//     super.initState();
//     polylinePoints = PolylinePoints();
//     this.setInitialLocation();
//   }

//   void setInitialLocation() {
//     currentLocation =
//         LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
//     destinationLocation =
//         LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Direction"),
//       ),
//       body: GoogleMap(
//         myLocationEnabled: true,
//         compassEnabled: false,
//         tiltGesturesEnabled: false,
//         polylines: _polylines,
//         markers: _markers,
//         onMapCreated: (GoogleMapController controller) {
//           mapController.complete(controller);

//           showMarker();
//           setPolylines();
//         },
//         initialCameraPosition: CameraPosition(
//           target: SOURCE_LOCATION,
//           zoom: 13,
//         ),
//       ),
//     );
//   }

//   void showMarker() {
//     setState(() {
//       _markers.add(Marker(
//         markerId: MarkerId('sourcePin'),
//         position: currentLocation,
//         icon: BitmapDescriptor.defaultMarker,
//       ));

//       _markers.add(Marker(
//         markerId: MarkerId('destinationPin'),
//         position: destinationLocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(90),
//       ));
//     });
//   }

//   void setPolylines() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         "AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno",
//         PointLatLng(currentLocation.latitude, currentLocation.longitude),
//         PointLatLng(
//             destinationLocation.latitude, destinationLocation.longitude));

//     if (result.status == 'OK') {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });

//       setState(() {
//         _polylines.add(Polyline(
//             width: 10,
//             polylineId: PolylineId('polyLine'),
//             color: Color(0xFF08A5CB),
//             points: polylineCoordinates));
//       });
//     }
//   }
// }