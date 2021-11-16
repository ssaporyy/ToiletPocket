import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
        body: 
        Container(
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

                          final Set<Marker> markers = new Set();

                          markers.add(Marker(
                            //add first marker
                            markerId: MarkerId('addToilet'),
                            position: LatLng(
                                document['currentlocationLat'],
                                document[
                                    'currentlocationLong']), //position of marker
                            infoWindow: InfoWindow(
                              //popup info
                              title: document['name'],
                            ),
                            icon:
                                BitmapDescriptor.defaultMarker, //Icon for Marker
                          ));

                          // Marker userAddMarker() {
                          //   return Marker(
                          //       markerId: MarkerId('addToilet'),
                          //       position: LatLng(document['currentlocationLat'],
                          //           document['currentlocationLong']),
                          //       icon: customIcon,
                          //       // BitmapDescriptor.defaultMarkerWithHue(150.0),
                          //       infoWindow: InfoWindow(title: document['name']));
                          // }

                          // Set<Marker> mySet() {
                          //   return <Marker>[userAddMarker()].toSet();
                          // }

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
                              markers: markers,
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
