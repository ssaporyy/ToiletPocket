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
        ImageConfiguration(size: Size(15, 15), devicePixelRatio: 2.5),
        /*'images/Icon-flush.png'*/ 'images/flush.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void _onMapCreated(GoogleMapController controller) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    final currentPosition = Provider.of<Position>(context);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('AddMarker'),
        position: LatLng(
            arguments['currentlocationLat'], arguments['currentlocationLong']),
        icon: customIcon,
        infoWindow: InfoWindow(title: arguments['name'])
      ));
    });
  }

  BitmapDescriptor sourceIcon;

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _mapController = Completer();
    final currentPosition = Provider.of<Position>(context);
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    Marker sourcePin() {
      return Marker(
        markerId: MarkerId('sourcepin'),
        position: LatLng(
            arguments['currentlocationLat'], arguments['currentlocationLong']),
        // icon: sourceIcon,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[sourcePin()].toSet();
    }

    Set<Circle> myCircles = Set.from([
      Circle(
        circleId: CircleId('pin add toilet'),
        center: LatLng(
            arguments['currentlocationLat'], arguments['currentlocationLong']),
        // center: LatLng(currentPosition.latitude, currentPosition.longitude),
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
                padding: EdgeInsets.only(top: 0),
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                compassEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(arguments['currentlocationLat'],
                      arguments['currentlocationLong']),
                  zoom: 18.0,
                  tilt: 20.0,
                ),
                onMapCreated: _onMapCreated,
                onCameraMove: null,
                circles: myCircles,
                markers: mySet(),
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
                        //??????????????????homepage
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      padding: EdgeInsets.all(10.0),
                      color: ToiletColors.colorButton2,
                      textColor: Colors.white,
                      child: Text(
                        "?????????????????????????????????????????????",
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
