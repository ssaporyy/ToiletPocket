import 'package:ToiletPocket/Show_toiletDetail_review/toiletdetail.dart';
import 'package:ToiletPocket/addComment/destination.dart';
import 'package:ToiletPocket/addToilet_InMap/addToilet.dart';
import 'package:ToiletPocket/addToilet_InMap/addToiletDetail.dart';
import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/addComment/addReviewComment.dart';
import 'package:ToiletPocket/provider/google_sign_in.dart';
import 'package:ToiletPocket/screen/firstScreen.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/screen/profile.dart';
import 'package:ToiletPocket/services/geolocator_service.dart';
import 'package:ToiletPocket/services/places_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';


Future main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoLocatorService = GeoLocatorService();
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);

    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => geoLocatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration =
              createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(
              configuration, 'images/flush.png');
        }),
        ProxyProvider2<Position, BitmapDescriptor, Future<List<Places>>>(
          update: (context, position, icon, places) {
            // print('re-render');
            return (position != null)
                ? placesService.getPlaces(
                    position.latitude,
                    position.longitude,
                    icon,
                  )
                : null;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationBloc(),
        ), //new
        ChangeNotifierProvider(create:  (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        title: 'Toilet App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/one',
        routes: <String, WidgetBuilder>{
          '/one': (context) => FirstScreen(),
          '/two': (context) => HomePage(),
          '/third': (context) => ToiletDetail(),
          '/four': (context) => Profile(),
          '/five': (context) => addToilet(),
          '/six': (context) => AddToiletDetail(),
          '/seven': (context) => AddComment(),
          '/eight': (context) => Destination(),
        },
      ),
    );
  }
}
