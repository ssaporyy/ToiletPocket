import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/place.dart';
// import 'package:ToiletPocket/models/location.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:ToiletPocket/star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
// import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/services.dart' as rootBundle;

// const LatLng SOURCE_LOCATION = LatLng(LocationData source);
class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  StreamSubscription locationSubscription;

  LatLng currentLocation;
  LatLng destinationLocation;

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  // StreamSubscription _locationSubscription;  Location _locationTracker = Location();
  @override
  void initState() {
    super.initState();

    polylinePoints = PolylinePoints();

    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        //set intitial location
        setIntitialLocation(place);

        //set marker icon
        // this.setSourceAndDestinationMarkerIcons();
      }
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
    var location = new Location();
    try {
      _currentPosition = await location.getLocation();
    } on Exception {
      _currentPosition = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 18.0,
        tilt: 20.0,
      ),
    ));
  }

  void setIntitialLocation(Place place) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    currentLocation =
        LatLng(applicationBloc.currentLocation.latitude,applicationBloc.currentLocation.longitude);
        
    destinationLocation =
        LatLng(place.geometry.location.lat, place.geometry.location.lng);
  }

  // Future<Uint8List> getMarker() async{
  //   ByteData byteData = await DefaultAssetBundle.of(context).load("images/navigation.png",);
  //   return byteData.buffer.asUint8List();
  // }

  // void updateMarker(LocationData newLocalData, Uint8List imgData){
  //   LatLng latlng = LatLng(newLocalData.latitude,newLocalData.longitude);
  //   this.setState(() {
  //     marker = Marker(
  //       markerId: MarkerId("my location"),
  //       position: latlng,
  //       rotation: newLocalData.heading,
  //       draggable: false,
  //       zIndex: 3,
  //       flat: true,
  //       icon: BitmapDescriptor.fromBytes(imgData)
  //     );
  //   });
  // }

  // void getCurrentLocation() async {
  //   try{
  //     Uint8List imgData= await getMarker();
  //     var location = await _locationTracker.getLocation();

  //     updateMarker(location, imgData);

  //     if(_locationSubscription != null){
  //       _locationSubscription.cancel();
  //     }

  //     _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
  //       if(_controller != null){
  //         _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //           target: LatLng(newLocalData.latitude,newLocalData.longitude),
  //           zoom: 16.0,
  //           tilt: 50.0, )));
  //           updateMarker(newLocalData, imgData);
  //       }
  //     });
  //   } on PlatformException catch (e){
  //     if(e.code == "PERMISSION_DENIED"){
  //       debugPrint("Permission Denied");
  //     }
  //   }
  // }
  // @override
  // void dispose(){
  //   if(_locationSubscription != null){
  //     _locationSubscription.cancel();
  //   }
  //   super.dispose();
  // }

  // Position _currentPosition;
  // String _currentAddress = '';

  // final startAddressController = TextEditingController();
  // final destinationAddressController = TextEditingController();

  // final startAddressFocusNode = FocusNode();
  // final desrinationAddressFocusNode = FocusNode();

  // String _startAddress = '';
  // String _destinationAddress = '';
  // String _placeDistance;

  // Set<Marker> markers = {};

  // PolylinePoints polylinePoints;
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];

  // final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    this.setSourceAndDestinationMarkerIcons(context);

    // Completer<GoogleMapController> _mapController = Completer();
    // final currentPosition = Provider.of<Position>(context);
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _place = _args['places'] as Places;
    // Set<Marker> markers = {};
    var width = MediaQuery.of(context).size.width;
    final startAddressController = GoogleMapController;

    return Scaffold(
        backgroundColor: ToiletColors.colorBackground,
        body: Stack(
          children: [
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polylines,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      applicationBloc.currentLocation.latitude, applicationBloc.currentLocation.longitude),
                  zoom: 18.0,
                  tilt: 20.0,
                  // bearing: 30,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                  showPinOnMap();
                  setPolylines();
                },
                // markers: Set<Marker>.of(markers),
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
                              hint: 'my location',
                              prefixIcon: Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  _currentLocation();
                                },
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
                              hint: '${_place.name}',
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
  void showPinOnMap(){
    setState(() {
      _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: currentLocation,
      icon: sourceIcon.toJson(),
      
    ));

    _markers.add(Marker(
      markerId: MarkerId('destinationPin'),
      position: destinationLocation,
      icon: destinationIcon.toJson(),
    ));
    });
  }

  void setPolylines() async{
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "<AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno>",
      PointLatLng(
        currentLocation.latitude, 
        currentLocation.longitude
      ),
      PointLatLng(
        destinationLocation.latitude, 
        destinationLocation.longitude
      ),
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
          Polyline(
            width: 20,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates
          )
        );
      });
    }
  }
}
