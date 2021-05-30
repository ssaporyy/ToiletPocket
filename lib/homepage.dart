import 'dart:async';
import 'package:ToiletPocket/application_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();

  GoogleMapController controller;
  Position currentLocation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  // _appBar(height) => PreferredSize(
  //       preferredSize: Size(
  //         MediaQuery.of(context).size.width, height + 180, ),
  //       child: Stack(
  //         children: <Widget>[

  //           //new search bar
  //           Container(
  //             margin: EdgeInsets.only(top: 100.0, left: 15.0, right: 15.0),
  //             padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
  //             decoration: BoxDecoration(
  //                 color: Colors.black12,
  //                 borderRadius: BorderRadius.circular(30),
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Colors.black12,
  //                       blurRadius: 5.0,
  //                       spreadRadius: 0.5,
  //                       offset: Offset(
  //                         0.7,
  //                         0.7,
  //                       ))
  //                 ]),
  //             child: TextField(
  //               // controller: _locationController,
  //               textCapitalization: TextCapitalization.words,
  //               textInputAction: TextInputAction.search,
  //               decoration: InputDecoration(
  //                 hintText: 'ค้นหาห้องน้ำ',
  //                 /*'Search',*/
  //                 hintStyle: TextStyle(
  //                     fontSize: 18.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
  //                 icon: Icon(
  //                   Icons.search,
  //                   color: Colors.black54,
  //                 ),
  //                 border: InputBorder.none,
  //                 suffixIcon: IconButton(
  //                   // onPressed: () => ,
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.account_circle,
  //                     size: 35,
  //                     color: Colors.black54,
  //                   ),
  //                 ),
  //               ),
  //               cursorColor: Colors.black87,
  //               style: TextStyle(height: 1.2, fontSize: 20.0),
  //               // onChanged: (value) => applicationBloc.searchPlaces(value),
  //               // onTap: () => applicationBloc.clearSelectedLocation(),
  //             ),
  //           ),
  //         ],
  //       ),

  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       icon: Icon(FontAwesomeIcons.arrowLeft),
      //       onPressed: () {
      //         //
      //       }),
      //   title: Text("New York"),
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(FontAwesomeIcons.search),
      //         onPressed: () {
      //           //
      //         }),
      //   ],
      // ),

      // appBar: _appBar(AppBar().preferredSize.height,),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   elevation: 0.0,
      //   brightness: Brightness.dark,
      // ),
      // extendBodyBehindAppBar: true,

      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          search(),  
          //ปุ่ม zoom เข้า-ออก        
          // _zoomminusfunction(),
          // _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget search() {
    return
        //new search bar
    Container(
      margin: EdgeInsets.only(top: 60.0, left: 27.0, right: 27.0),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
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
      child: TextField(
        // controller: _locationController,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'ค้นหาห้องน้ำ',
          /*'Search',*/
          hintStyle:
              TextStyle(fontSize: 18.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
          icon: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          border: InputBorder.none,
          suffixIcon: IconButton(
            // onPressed: () => ,
            onPressed: () {},
            icon: Icon(
              Icons.account_circle,
              size: 35,
              color: Colors.black54,
            ),
          ),
        ),
        cursorColor: Colors.black87,
        style: TextStyle(height: 1.2, fontSize: 20.0),
        // onChanged: (value) => applicationBloc.searchPlaces(value),
        // onTap: () => applicationBloc.clearSelectedLocation(),
      ),
    );
  }

//ปุ่ม zoom เข้า-ออก
  // Widget _zoomminusfunction() {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: IconButton(
  //         icon: Icon(OMIcons.zoomIn, color: Color(0xff6200ee)),
  //         onPressed: () {
  //           zoomVal--;
  //           _minus(zoomVal);
  //         }),
  //   );
  // }

  // Widget _zoomplusfunction() {
  //   return Align(
  //     alignment: Alignment.topRight,
  //     child: IconButton(
  //         icon: Icon(OMIcons.zoomOut, color: Color(0xff6200ee)),
  //         onPressed: () {
  //           zoomVal++;
  //           _plus(zoomVal);
  //         }),
  //   );
  // }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 180.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipORp6yyQOYLlycgjzYCXOgNjykKvfFlPrkTHPxo=w408-h272-k-no",
                  13.65004,
                  100.49449,
                  "มหาวิทยาลัยเทคโนโลยี\nพระจอมเกล้าธนบุรี"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPBP8muRmeYLaGWKkKFmXaSHHs2WH55Ah4AKYeh=w408-h271-k-no",
                  13.66,
                  100.49449,
                  "KMUTT Library"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipP-W915Ac24QVcnF3WKnDx6KxyPoM6HL74zWfPZ=w408-h306-k-no",
                  13.65004,
                  100.49449,
                  "โรงอาหาร มจธ."),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
                  40.761421,
                  -73.981667,
                  "Le Bernardin"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  40.732128,
                  -73.999619,
                  "Blue Hill"),
            ),


          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 400,
                    height: 330,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(0.0),
                          bottomLeft: Radius.circular(0.0),
                        ),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 30.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 13.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              ),
            )),
            Container(
              child: Icon(
                OMIcons.star,
                color: Colors.amber,
                size: 18.0,
              ),
            ),
            Container(
              child: Icon(
                OMIcons.star,
                color: Colors.amber,
                size: 18.0,
              ),
            ),
            Container(
              child: Icon(
                OMIcons.star,
                color: Colors.amber,
                size: 18.0,
              ),
            ),
            Container(
              child: Icon(
                OMIcons.star,
                color: Colors.amber,
                size: 18.0,
              ),
            ),
            Container(
              child: Icon(
                OMIcons.starHalf,
                color: Colors.amber,
                size: 18.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              ),
            )),
          ],
        )),
        SizedBox(height: 9.0),

        Row(
          children: [
            Container(
                child: Text(
              "Kmutt \u00B7 ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              ),
            )
            ),
            Container(
                child: Icon(OMIcons.directionsCar)
            ),
            Container(
                child: Text(
              "\u00B7 1.6 mi",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              ),
            )
            ),
          ],
        ),


        SizedBox(height: 6.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 20.0,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    final applicationbloc = Provider.of<Applicationbloc>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        
        // จากหน้า map
        padding: EdgeInsets.only(
          top: 110,
          right: 20,
          bottom: 189,
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(applicationbloc.currentLocation.latitude,
              applicationbloc.currentLocation.longitude),
          zoom: 16.0,
        ),
        
        // onMapCreated: (controller) => _googleMapController = controller,

        //new
        mapType: MapType.normal,
        // initialCameraPosition:
        //     CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },


        markers: {
          newyork1Marker,
          newyork2Marker,
          newyork3Marker,
          gramercyMarker,
          bernardinMarker,
          kmuttMarker,
          blueMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker kmuttMarker = Marker(
  markerId: MarkerId('Kumtt'),
  position: LatLng(13.65004,100.49449),
  infoWindow: InfoWindow(title: 'มหาวิทยาลัยเทคโนโลยี\nพระจอมเกล้าธนบุรี'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(40.729640, -73.983510),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(40.719109, -74.000183),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
