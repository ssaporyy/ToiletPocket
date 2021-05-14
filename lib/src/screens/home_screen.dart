import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      body:   SizedBox.expand(
        child: Stack(children: <Widget>[
      // (applicationBloc.currentLocation == null)
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : ListView(
              // children: [
              //   TextField(
              //     decoration: InputDecoration(hintText: 'Search Location'),
              //   ),
                Container(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(applicationBloc.currentLocation.latitude,
                          applicationBloc.currentLocation.longitude),
                      zoom: 15,
                    ),
                  ),
                ),

                // button current location
                // Container(
                //   color: Colors.transparent,
                //   margin: EdgeInsets.all(15),
                //   padding: const EdgeInsets.fromLTRB(
                //       310 /*left*/, 110 /*top*/, 0 /*right*/, 0 /*bottom*/),
                //   child: FloatingActionButton(
                //     backgroundColor: Colors.white.withOpacity(0.8),
                //     foregroundColor: Colors.black,
                //     // onPressed: ,
                //     child: Icon(
                //       Icons.my_location,
                //       size: 20,
                //     ),
                //   ),
                // ),

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
              ],
            ),
      ),
    );
  }
}
