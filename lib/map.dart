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
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
          target: LatLng(13.7650836, 100.5379664),
          zoom: 16,
        ),
            onMapCreated: (controller) => _googleMapController = controller,
          ),

//button current location
          Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(15),
            padding: const EdgeInsets.fromLTRB(
                320 /*left*/, 110 /*top*/, 0 /*right*/, 0 /*bottom*/),
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
                      // Icon(
                      //   OMIcons.search,
                      //   color: Colors.blueAccent,
                      // ),
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, 'third');
                        },
                        icon: Icon(OMIcons.search),
                        label: Text('Search Destination'),
                        textColor: Colors.black54,
                      ),

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
        ]),
      ),
    );
  }
}
