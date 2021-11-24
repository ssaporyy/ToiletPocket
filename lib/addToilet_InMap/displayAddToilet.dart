import 'dart:async';

import 'package:ToiletPocket/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DisplayAddToilets extends StatefulWidget {
  const DisplayAddToilets({Key key}) : super(key: key);

  @override
  _DisplayAddToiletsState createState() => _DisplayAddToiletsState();
}

class _DisplayAddToiletsState extends State<DisplayAddToilets> {
  CameraPosition position;

  Set<Marker> _markers = Set<Marker>();
  BitmapDescriptor customIcon;

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(/*size: Size(40, 40)*/ devicePixelRatio: 2.5),
        'images/Icon-flush.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void _onMapCreated(GoogleMapController controller) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('AddMarker'),
          position: LatLng(arguments['currentlocationLat'],
              arguments['currentlocationLong']),
          icon: customIcon,
          infoWindow: InfoWindow(title: arguments['name'])));
    });
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _mapController = Completer();
    final currentPosition = Provider.of<Position>(context);
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    Set<Circle> myCircles = Set.from([
      Circle(
        circleId: CircleId('pin add toilet'),
        center: LatLng(currentPosition.latitude, currentPosition.longitude),
        radius: 80,
        fillColor: Colors.blue.shade100.withOpacity(0.5),
        strokeColor: Colors.blue.shade100.withOpacity(0.1),
      )
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ToiletColors.colorButton,
        // body: add(context),
        body: Stack(
          children: [
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                padding: EdgeInsets.only(top: 610),
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(arguments['currentlocationLat'],
                      arguments['currentlocationLong']),
                  // target: LatLng(
                  //     currentPosition.latitude, currentPosition.longitude),
                  zoom: 18.0,
                  tilt: 20.0,
                  // bearing: 30,
                ),
                onMapCreated: 
                _onMapCreated,
                // (GoogleMapController controller) {
                //   _mapController.complete(controller);
                // },
                onCameraMove: null,
                circles: myCircles,
                // markers: Set<Marker>.of(markers),
                markers: _markers,
                // markers: mySet(),
                // myLocationButtonEnabled: false,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 130,
                  width: double.maxFinite,
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
                  child: Container(
                    margin: EdgeInsets.all(40),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: ToiletColors.colorButton2)),
                      onPressed: () {
                        //ไปหน้าhomepage
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      padding: EdgeInsets.all(10.0),
                      color: ToiletColors.colorButton2,
                      textColor: Colors.white,
                      child: Text(
                        "กลับสู่หน้าหลัก",
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
