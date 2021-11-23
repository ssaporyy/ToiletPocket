import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:typed_data';

import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/star.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:math' show cos, sqrt, asin;

class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  StreamSubscription locationSubscription;

  LatLng currentLocation;
  LatLng destinationLocation;

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String _placeDistance;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    Future.delayed(Duration.zero, () {
      this.setIntitialLocation();
    });
  }

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(55, 55)), 'images/navigation.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(55, 55)), 'images/flush.png');
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData _currentPosition;

    final _args = 
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _currentlocation = _args['current'] as Position;

    final _place = _args['places'] as Places;
    // var location = new Location();
    // try {
    //   _currentPosition = await location.getLocation();
    // } on Exception {
    //   _currentPosition = null;
    // }
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(_currentlocation.latitude, _currentlocation.longitude),
        zoom: 13.6,
        tilt: 20.0,
      ),
    ));
  }

  void setIntitialLocation() {
    print('init');
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _currentlocation = _args['current'] as Position;
    final _place = _args['places'] as Places;
    LatLng DEST_LOCATION =
        LatLng(_place.geometry.location.lat, _place.geometry.location.lng);
    currentLocation =
        LatLng(_currentlocation.latitude, _currentlocation.longitude);
    destinationLocation =
        LatLng(_place.geometry.location.lat, _place.geometry.location.lng);
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
              color: Colors.blue.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade100,
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
    this.setSourceAndDestinationMarkerIcons(context);
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _currentlocation = _args['current'] as Position;
    final _place = _args['places'] as Places;
    var width = MediaQuery.of(context).size.width;
    final startAddressController = GoogleMapController;
    final user = FirebaseAuth.instance.currentUser;

    Marker sourcePin() {
      // print('=================src lat: ${_currentlocation.latitude}');
      // print('=================src lng: ${_currentlocation.longitude}');
      return Marker(
        markerId: MarkerId('sourcepin'),
        position: LatLng(_currentlocation.latitude, _currentlocation.longitude),
        // icon: sourceIcon,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
    }

    Marker destinationPin() {
      // print('=================dest lat: ${_place.geometry.location.lat}');
      // print('=================dest lng: ${_place.geometry.location.lng}');
      return Marker(
        markerId: MarkerId('destinationpin'),
        position:
            LatLng(_place.geometry.location.lat, _place.geometry.location.lng),
        // icon: destinationIcon,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[sourcePin(), destinationPin()].toSet();
    }

    final current = _place;


    _culculateDistance(){
      double totalDistance = 0.0;
      double _coordinateDistance(lat1, lon1, lat2, lon2){
       final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _currentlocation = _args['current'] as Position;
    final _place = _args['places'] as Places;

    lat1 = _currentlocation.latitude;
    lon1 = _currentlocation.longitude;
    lat2 = _place.geometry.location.lat;
    lon2 = _place.geometry.location.lng;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }
      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });
      return _placeDistance;
    } 

    return Scaffold(
        backgroundColor: ToiletColors.colorBackground,
        body: Stack(
          children: [
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                markers: mySet(),
                /*_markers,*/
                polylines: _polylines,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      _currentlocation.latitude, _currentlocation.longitude),
                  zoom: 13.6,
                  tilt: 20.0,
                ),
                // onCameraMove: (position) {
                //   setState(() {
                //     mySet().add(
                //         Marker(markerId: MarkerId('id'), position: position.target));
                //   });
                // },
                padding: EdgeInsets.only(left: 500),
            
                //อันเก่า ------------------------------------------
                onMapCreated: (GoogleMapController controller) async {
                  print('on created');
                  try {
                    _controller.complete(controller);
                  } catch (e) {
                    print('controller');
                    print(e);
                  }

                  try {
                    showPinOnMap();
                  } catch (e) {
                    print('show pin');
                    print('error pin: $e');
                    print('-----------------=============-------------');
                  }

                  try {
                    setPolylines();
                  } catch (e) {
                    print('set poly line');
                    print(e);
                  }
                },
              
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
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
                          'Destination',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        _textField(
                            hint: 'my location',
                            prefixIcon: Icon(
                              Icons.looks_one,
                              color: Colors.blue[400],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.my_location,
                                  color: Colors.blue[400]),
                              onPressed: () {
                                _currentLocation();
                                // print(calculateDistance(lat1, lon1, lat2, lon2));
                              },
                            ),
                            width: width,
                            locationCallback: (String value) {
                              setState(() {});
                            }),
                        SizedBox(height: 10),
                        _textField(
                            hint: '${_place.name}',
                            prefixIcon: Icon(
                              Icons.looks_two,
                              color: Colors.blue[400],
                            ),
                            width: width,
                            locationCallback: (String value) {
                              setState(() {
                                // _destinationAddress = value;
                              });
                            }),
                        SizedBox(height: 10),
                        SizedBox(height: 5),
                      ],
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
                                    // '(km)',
                                    '${_culculateDistance()} km',
                                    // '(${distance}km)',

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
                                  onPressed: () {
                                    // print('${_currentlocation.latitude}'
                                    //     '++++++'
                                    //     '${_currentlocation.longitude}');
                                    // print('${_place.geometry.location.lat}'
                                    //     '++++++'
                                    //     '${_place.geometry.location.lng}');

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(children: [
                                              Text(
                                                "รีวิวและประเมินห้องน้ำ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  fontFamily:
                                                      'Sukhumvit' ?? 'SF-Pro',
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  height: 80, child: Star()),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 47,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        30.0)),
                                                      ),
                                                      child: ElevatedButton(
                                                        // Within the `FirstScreen` widget
                                                        style: ElevatedButton.styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            primary: ToiletColors
                                                                .colorButton2,
                                                            elevation: 5.0),

                                                        child: Image.asset(
                                                          'images/comment.png',
                                                          alignment:
                                                              Alignment.center,
                                                          width: 35,
                                                        ),
                                                        onPressed: () {
                                                          // Navigate to the second screen using a named route.
                                                          if (user
                                                              .isAnonymous) {
                                                            return Navigator
                                                                .pushNamed(
                                                              context,
                                                              '/nine',
                                                            );
                                                          } else
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/seven',
                                                                arguments: {
                                                                'placeId':current,
                                                              },
                                                                );print('+++''${current.placeId}');
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 47,
                                                      child: ElevatedButton(
                                                        // Within the `FirstScreen` widget 
                                                        style: ElevatedButton.styleFrom(
                                                            shape:
                                                                StadiumBorder(),
                                                            primary: ToiletColors
                                                                .colorButton2,
                                                            elevation: 5.0),

                                                        child: Text(
                                                          'ยืนยัน',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Sukhumvit' ??
                                                                      'SF-Pro',
                                                              fontSize: 20),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          // Navigator.pushNamed(
                                                          //     context, '/two');
                                                        },
                                                      ),
                                                    ),
                                                  ]),
                                              SizedBox(
                                                height: 15,
                                              ),
                                            ]),
                                          ],
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  padding: EdgeInsets.all(10.0),
                                  color: ToiletColors.colorButton2,
                                  textColor: Colors.white,
                                  child: Text(
                                    "สิ้นสุดปลายทาง",
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
                              Navigator.pop(context);
                              // Navigator.pushNamed(context, '/two');
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

  void showPinOnMap() {
    print('1st');
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    print('2nd');
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print('3rd');
    final _currentlocation = _args['current'] as Position;
    final _place = _args['places'] as Places;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: LatLng(_currentlocation.latitude,
            _currentlocation.longitude),
        icon: BitmapDescriptor.defaultMarker,
      ));

      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position:
            LatLng(_place.geometry.location.lat, _place.geometry.location.lng),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
//อันเก่า
  void setPolylines() async {
    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    print('current lat: ${currentLocation.latitude}');
    print('current lng: ${currentLocation.longitude}');
    print('dest lat:${destinationLocation.latitude}');
    print('dest lng:${destinationLocation.longitude}');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno",
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    print('=====status: ${result.status}');
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        print("printtttttttttttttt" '${point.latitude}' "${point.longitude}");
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 5,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }
}
