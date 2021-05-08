import 'dart:async';
import 'package:ToiletPocket/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(13.757429, 100.502465),
    zoom: 15,
  );

  GoogleMapController _googleMapController;




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
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
          ),
          //ตัวเก่า
          // FloatingActionButton(
          //   backgroundColor: Colors.white,
          //   onPressed: () => _googleMapController.animateCamera(
          //       CameraUpdate.newCameraPosition(_initialCameraPosition)),
          // ),

          Container(
              margin: EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(
                290 /*left*/, 620 /*top*/, 0 /*right*/, 0 /*bottom*/),
              child: FloatingActionButton(
                backgroundColor:
                    Colors.white, //Theme.of(context).primaryColorLight,
                foregroundColor: Colors.black,
                onPressed: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(_initialCameraPosition),
                ),

                child: Icon(
                  Icons.my_location,
                  size: 31,
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
                                  height: 150.0,
                                  width: 150.0,
                                  image: AssetImage('images/mmm.png'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 13),
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
                              ],
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
