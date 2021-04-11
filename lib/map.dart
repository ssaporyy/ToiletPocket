import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(13.757429, 100.502465), //กำหนดพิกัดเริ่มต้นบนแผนที่
            zoom: 15, //กำหนดระยะการซูม สามารถกำหนดค่าได้ 0-20
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
