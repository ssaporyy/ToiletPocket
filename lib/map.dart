// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
// import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

// Future<LocationData> getCurrentLocation() async {
//   Location location = Location();
//   try {
//     return await location.getLocation();
//   } on PlatformException catch (e) {
//     if (e.code == 'PERMISSION_DENIED') {
//       // Permission denied
//     }
//     return null;
//   }
// }



class MapSampleState extends State<MapSample> {
  static const _intitialCameraPosition = CameraPosition(
    target: LatLng(13.7650836, 100.5379664),
    zoom: 16,
    );

  GoogleMapController _googleMapController;
  Position position;
  Widget _child;


  // Future<void> getLocation() async {
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.location);

  //   if (permission == PermissionStatus.denied) {
  //     await PermissionHandler()
  //         .requestPermissions([PermissionGroup.locationAlways]);
  //   }

  //   var geolocator = Geolocator();

  //   GeolocationStatus geolocationStatus =
  //       await geolocator.checkGeolocationPermissionStatus();

  //   switch (geolocationStatus) {
  //     case GeolocationStatus.denied:
  //       showToast('denied');
  //       break;
  //     case GeolocationStatus.disabled:
  //       showToast('disabled');
  //       break;
  //     case GeolocationStatus.restricted:
  //       showToast('restricted');
  //       break;
  //     case GeolocationStatus.unknown:
  //       showToast('unknown');
  //       break;
  //     case GeolocationStatus.granted:
  //       showToast('Access granted');
  //       _getCurrentLocation();
  //   }
  // }


  // LocationData currentLocation;

  // Future _goToMe() async {
  //   final GoogleMapController controller = await _googleMapController;
  //   currentLocation = await getCurrentLocation();
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //     zoom: 16,
  //   )));
  // }

  // @override
  // void dispose() {
    // _googleMapController.dispose();
    // super.dispose();
  // }

  // void locatePosition() async{
  // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // currentPosition = position;

  // LatLng latLatPosition = LatLng(position.latitude, position.longitude);

  // CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom:14);
  // _googleMapController.animateCamera(
                // CameraUpdate.newCameraPosition(cameraPosition));


// }

// @override
//   void initState() {
//     getLocation();
//     super.initState();
//   }
//   void _getCurrentLocation() async{
//     Position res = await Geolocator().getCurrentPosition();
//     setState(() {
//       position = res;
//       _child = _mapWidget();
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(top: 54, right: 55),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            
      //       initialCameraPosition:CameraPosition(
      //   target: LatLng(position.latitude,position.longitude),
      //   zoom: 12.0,
      // ),
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
              // onPressed: _goToMe,
              onPressed : () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(_intitialCameraPosition)),
              child: Icon(
                Icons.my_location,
                size: 20,
              ),
            ),
          ),

          //new search bar
          Container(
            margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
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
            child: TextField(
              // controller: _locationController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'ค้นหาห้องน้ำ',
                /*'Search',*/
                hintStyle: TextStyle(
                    fontSize: 18.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  // onPressed: () => ,
                  onPressed: () {},
                  icon: Icon(
                    Icons.account_circle,
                    size: 35,
                    color: Colors.black54,
                  ),
                ),
              ),
              cursorColor: Colors.black87,
              style: TextStyle(height: 1.2, fontSize: 20.0),
              // onChanged: (value) => applicationBloc.searchPlaces(value),
              // onTap: () => applicationBloc.clearSelectedLocation(),
            ),
          ),

          // //search bar
          // Container(
          //   margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(30),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.black12,
          //             blurRadius: 5.0,
          //             spreadRadius: 0.5,
          //             offset: Offset(
          //               0.7,
          //               0.7,
          //             ))
          //       ]),
          //   child: Padding(
          //     padding: const EdgeInsets.all(2.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Row(
          //           children: [
          //             // Icon(
          //             //   OMIcons.search,
          //             //   color: Colors.blueAccent,
          //             // ),
          //             FlatButton.icon(
          //               onPressed: () {
          //                 Navigator.pushNamed(context, 'third');
          //               },
          //               icon: Icon(OMIcons.search),
          //               label: Text('Search Destination'),
          //               textColor: Colors.black54,
          //             ),

          //             SizedBox(
          //               width: 10,
          //             ),
          //           ],
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          //           child: Icon(
          //             Icons.account_circle,
          //             color: Colors.blueAccent,
          //             size: 35,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
