// import 'dart:async';
import 'package:ToiletPocket/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

// Set<Marker> _markers = {};
// BitmapDescriptor mapMarker;

// @override
// void initState() {
//   super.initState();
//   setCustomMarker();
// }

// void setCustomMarker() async {
//   mapMarker = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(size: Size(55,55)), 'images/flush.png');
// }

// void _onMapCreated(GoogleMapController) {
//   setState(() {
//     _markers.add(
//       Marker(
//         markerId: MarkerId('id-1'),
//         position: LatLng(13.649894, 100.498704),
//         icon: mapMarker,
//         infoWindow: InfoWindow(
//           title: 'Toilet Packet',
//           snippet: 'Address place',
//         ),
//       ),
//     );
//   });
// }

Marker mytoilet = Marker(
  markerId: MarkerId('id-1'),
  position: LatLng(13.7650836, 100.5379664),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueCyan,
  ),
  infoWindow: InfoWindow(
    title: 'Toilet Packet',
    snippet: 'Address place',
  ),
);

Marker mytoilet2 = Marker(
  markerId: MarkerId('id-2'),
  position: LatLng(13.757429, 100.502465),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
  infoWindow: InfoWindow(
    title: 'Toilet Packet',
    snippet: 'MyAddress place',
  ),
);

Future<LocationData> getCurrentLocation() async {
  Location location = Location();
  try {
    return await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      // Permission denied
    }
    return null;
  }
}

class MapSampleState extends State<MapSample> {
  GoogleMapController _googleMapController;
  LocationData currentLocation;

  Future _goToMe() async {
    final GoogleMapController controller = await _googleMapController;
    currentLocation = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 16,
    )));
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // currentLocation = getCurrentLocation() as LocationData;

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(13.7650836, 100.5379664),
              // target: LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 16,
            ),
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {mytoilet, mytoilet2},
            // markers: _markers,
          ),

//button current location
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(15),
            padding: const EdgeInsets.fromLTRB(
                310 /*left*/, 110 /*top*/, 0 /*right*/, 0 /*bottom*/),
            child: FloatingActionButton(
              backgroundColor: Colors.white.withOpacity(0.8),
              //Theme.of(context).primaryColorLight,
              foregroundColor: Colors.black,
              onPressed: _goToMe,
              child: Icon(
                Icons.my_location,
                size: 20,
              ),
            ),
          ),

          //search bar
          Container(
            margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        OMIcons.search,
                        color: Colors.blueAccent,
                      ),
          
                      // FlatButton.icon(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, 'third');
                      //   },
                      //   icon: Icon(OMIcons.search),
                      //   label: Text('Search Destination'),
                      //   textColor: Colors.black54,
                      // ),
          
                      TextField(
                        decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18))),
          
          
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.blueAccent,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),


          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.4,
              builder: (BuildContext c, s) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: ListView(
                    controller: s,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Image(
                                  //alignment: Alignment.bottomLeft,
                                  height: 120.0,
                                  width: 120.0,
                                  image: AssetImage('images/mmm.png'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Where are you going?',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Brand-Bold'),
                                ),
                                Text(
                                  'Where are you going?',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Where are you going?',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Brand-Bold'),
                                ),
                                Text(
                                  'Where are you going?',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Brand-Bold'),
                                ),
                                Text(
                                  'Where are you going?',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'Brand-Bold'),
                                ),
                                // Text(
                                //   'Where are you going?',
                                //   style: TextStyle(
                                //       fontSize: 15, fontFamily: 'Brand-Bold'),
                                // ),
                                // Text(
                                //   'Where are you going?',
                                //   style: TextStyle(
                                //       fontSize: 15, fontFamily: 'Brand-Bold'),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          Container(
                            color: Colors.transparent,
                            // margin: EdgeInsets.all(3),
                            // padding: const EdgeInsets.fromLTRB( 5 /*left*/,
                            //      1 /*top*/, 0 /*right*/, 0 /*bottom*/),
                            child: FloatingActionButton(
                              backgroundColor: Colors.grey[400],
                              // onPressed: _goToMe,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Nice to see you!',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        'Name Location',
                        style:
                            TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.room,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Add Name Toilet'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'location address',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.watchLater,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Add Time'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'close-open',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.info,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Add Info'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'List',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.info,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Add Info'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'List',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.info,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Add Info'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'List',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            OMIcons.info,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Add Info'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'List',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: BrandColors.colorDimText,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
