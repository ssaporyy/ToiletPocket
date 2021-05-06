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
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition)),),

          //search bar
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
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
              padding: const EdgeInsets.all(6.0),
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
                        icon: Icon(OMIcons.search),label: Text('Search Destination'),textColor: Colors.black54,
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      // Text(
                      //   'Search Destination',
                      //   style: TextStyle(color: Colors.black54),
                      // ),
                      // FlatButton(
                      //     onPressed: () {
                      //       Navigator.pushNamedAndRemoveUntil(
                      //           context, SearchBar.id, (route) => false);
                      //     },
                      //     child: Text('Search Destination')),
                    ],
                  ),
                  // onPressed: () {
                  // Navigator.pushNamed(context, SearchBar.id);}
                  // IconButton(
                  //   icon: const Icon(Icons.account_circle),
                  //   iconSize: 30.0,
                  //   color: Colors.blueAccent,
                  //   // onPressed: () {
                  //   //   Navigator.pushNamed(context, SearchBar.id);
                  //   // },
                  // ),
                  Icon(
                    Icons.account_circle,
                    color: Colors.blueAccent,
                    size: 30,
                  ),                      
                ],
              ),

              // FlatButton(
              //     onPressed: () {
              //       Navigator.pushNamedAndRemoveUntil(
              //           context, RegistrationPage.id, (route) => false);
              //     },
              //     child: Text('Don\'t have an account, sign up here')),
            ),
          ),


          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.2,
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
                    child: Column(children: <Widget>[
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

                    ],),
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
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'Brand-Bold'),
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
