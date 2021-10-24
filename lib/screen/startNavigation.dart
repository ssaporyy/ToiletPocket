import 'dart:async';

import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/star.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:outline_material_icons/outline_material_icons.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ToiletColors.colorBackground,
      body: add(context),
    );
  }
}

Widget add(BuildContext context) {
  Completer<GoogleMapController> _mapController = Completer();
  final currentPosition = Provider.of<Position>(context);
  final _args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
  final _place = _args['places'] as Places;


  return Stack(
    children: [
      Container(
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 18.0,
            tilt: 20.0,
            // bearing: 30,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          //color of shadow
                          spreadRadius: 3, //spread radius
                          blurRadius: 9, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                      ]),
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
                            'ชื่อห้องน้ำ'
                          //  _place.name
                           ,
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
                              side:
                                  BorderSide(color: ToiletColors.colorButton2)),
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
      )
    ],
  );
}
