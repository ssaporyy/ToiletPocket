import 'dart:async';

import 'package:ToiletPocket/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  @override
   Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(13.757429, 100.502465), //กำหนดพิกัดเริ่มต้นบนแผนที่
              zoom: 15, //กำหนดระยะการซูม สามารถกำหนดค่าได้ 0-20
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
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
