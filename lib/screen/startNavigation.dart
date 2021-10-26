import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:ToiletPocket/star.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
// import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/services.dart' as rootBundle;

class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  void initState() {
    super.initState();
  }

  Widget _textField({
    TextEditingController controller,
    FocusNode focusNode,
    String label,
    String hint,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        // enabled: false,
        readOnly: true,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _mapController = Completer();
    final currentPosition = Provider.of<Position>(context);
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _place = _args['places'] as Places;
    Set<Marker> markers = {};
    var width = MediaQuery.of(context).size.width;
    final startAddressController = GoogleMapController;

    return Scaffold(
        backgroundColor: ToiletColors.colorBackground,
        body: Stack(
          children: [
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentPosition.latitude, currentPosition.longitude),
                  zoom: 18.0,
                  tilt: 20.0,
                  // bearing: 30,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
                markers: Set<Marker>.of(markers),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Places',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10),
                          _textField(
                              // label: 'Start',
                              hint: 'wasan',
                              prefixIcon: Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                // onPressed: () {
                                //   startAddressController = _currentAddress;
                                //   _startAddress = _currentAddress;
                                // },
                              ),
                              // controller: startAddressController,
                              // focusNode: startAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  // _startAddress = value;
                                });
                              }),
                          SizedBox(height: 10),
                          _textField(
                              // label: 'Destination',
                              hint: 'Choose destination',
                              prefixIcon: Icon(Icons.looks_two),
                              // controller: destinationAddressController,
                              // focusNode: desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  // _destinationAddress = value;
                                });
                              }),
                          SizedBox(height: 10),
                          // Visibility(
                          //   visible: _placeDistance == null ? false : true,
                          //   child: Text(
                          //     'DISTANCE: $_placeDistance km',
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 5),
                          // ElevatedButton(
                          //   onPressed: (_startAddress != '' &&
                          //           _destinationAddress != '')
                          //       ? () async {
                          //           startAddressFocusNode.unfocus();
                          //           desrinationAddressFocusNode.unfocus();
                          //           setState(() {
                          //             if (markers.isNotEmpty) markers.clear();
                          //             if (polylines.isNotEmpty)
                          //               polylines.clear();
                          //             if (polylineCoordinates.isNotEmpty)
                          //               polylineCoordinates.clear();
                          //             _placeDistance = null;
                          //           });

                          //           _calculateDistance().then((isCalculated) {
                          //             if (isCalculated) {
                          //               ScaffoldMessenger.of(context)
                          //                   .showSnackBar(
                          //                 SnackBar(
                          //                   content: Text(
                          //                       'Distance Calculated Sucessfully'),
                          //                 ),
                          //               );
                          //             } else {
                          //               ScaffoldMessenger.of(context)
                          //                   .showSnackBar(
                          //                 SnackBar(
                          //                   content: Text(
                          //                       'Error Calculating Distance'),
                          //                 ),
                          //               );
                          //             }
                          //           });
                          //         }
                          //       : null,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Text(
                          //       'Show Route'.toUpperCase(),
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20.0,
                          //       ),
                          //     ),
                          //   ),
                          //   style: ElevatedButton.styleFrom(
                          //     primary: Colors.red,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(20.0),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                //color of shadow
                                spreadRadius: 3, //spread radius
                                blurRadius: 9, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              ),
                            ]),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Column(
                                children: [
                                  Text(
                                    // 'ชื่อห้องน้ำ'
                                    _place.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '... นาที',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '(... km)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 220,
                                margin: EdgeInsets.all(0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: ToiletColors.colorButton2)),
                                  onPressed: () {},
                                  padding: EdgeInsets.all(10.0),
                                  color: ToiletColors.colorButton2,
                                  textColor: Colors.white,
                                  child: Text(
                                    "เริ่มต้น",
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //   );
                        // }),
                      ),
                    ),
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/direction.png',
                            width: 55,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(left: 7),
                height: 130,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              alignment: Alignment.center,
                              primary: Colors.black,
                              padding: EdgeInsets.all(5),
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              ),
                            ),
                            onPressed: () {
                              // Navigator.pop(context);
                              Navigator.pushNamed(context, '/two');
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'กลับ',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
