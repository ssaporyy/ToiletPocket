import 'package:ToiletPocket/Show_toiletDetail_review/CarouselWithDotsPage.dart';
import 'package:ToiletPocket/Show_toiletDetail_review/review.dart';
import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class ToiletDetail extends StatefulWidget {
  ToiletDetail({Key key}) : super(key: key);

  @override
  ToiletDetailState createState() => ToiletDetailState();
}

class ToiletDetailState extends State<ToiletDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: back(context),
      body: Stack(
        children: <Widget>[
          // back(context),
          appbar(context),
          // slide(context),
        ],
      ),
    );
  }
}

Widget appbar(BuildContext context) {
  back(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 180),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 55.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/two');
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 18,
                      color: Colors.black87,
                    ),
                    Text(
                      'กลับ',
                      style: TextStyle(
                        color: Colors.black87,
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
      );

  return MaterialApp(
    home: Scaffold(
      backgroundColor: ToiletColors.colorBackground,
      appBar: back(AppBar().preferredSize.height),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: ToiletColors.colorBackground
                  .withOpacity(0.9), //color of shadow
              spreadRadius: 5, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        child:
            Container(padding: EdgeInsets.only(top: 27), child: slide(context)),
        // Testpage(),
      ),
    ),
  );
}

Widget slide(BuildContext context) {
  final applicationBloc = Provider.of<ApplicationBloc>(context);
  return SingleChildScrollView(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Column(
      children: <Widget>[
        img(context),
        toiletLocation(context),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: time(context),
        ),
        //ไอคอนแสดง ห้องน้ำคนพิการ ที่สูญบุหรี่
        // Padding(
        //   padding: const EdgeInsets.only(left: 3),
        //   child: info(context),
        // ),
        rate(context),
      ],
    ),
  );
}

Widget img(BuildContext context) {
  // final _place = ModalRoute.of(context)?.settings.arguments as Places;
  // final photoReference = _place
  //         .photos
  //         .isEmpty
  //     ? ''
  //     : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${_place.photos[0].photoReference}&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno";

  final List<String> imgList = [
    // "https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg",
    // 'https://media4.s-nbcnews.com/i/newscms/2020_26/1583450/public-restroom-corona-kb-main-200623_9519eb6bd31f5da24860f90cb8fc60af.jpg',
    // 'https://whyy.org/wp-content/uploads/2020/04/bigstock-Toilet-Shot-In-Detail-In-A-Whi-236077285.jpg',
    // 'https://media.architecturaldigest.com/photos/56cce09bd2db26483dc7f7b0/2:1/w_5398,h_2699,c_limit/Master%20Bathroom%20-%20Shower%20View%20-After.jpg',
    // 'https://www.thespruce.com/thmb/uGGY19t5PZ323A0ANVSQjrviHgY=/1820x1365/smart/filters:no_upscale()/remodel-small-bathrooms-efficiently-1821379-hero-366429e654034a0e9713ea5e27f3186b.jpg',
    // 'https://www.smarthomesounds.co.uk/wp/wp-content/uploads/2019/07/In-celing-1-1410x650.jpg',
    'images/toilets/1.jpg',
    'images/toilets/2.jpg',
    'images/toilets/3.jpg',
    'images/toilets/4.jpg',
    'images/toilets/5.jpg',
    'images/toilets/6.jpg',
    // photoReference,

    // _place.photos.isEmpty
    //     ? 'https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg'
    //     : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${_place.photos[0].photoReference}&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno",
  ];
  return Container(
    padding: EdgeInsets.fromLTRB(0, 0, 20, 5),
    child: Column(
      children: [
        CarouselWithDotsPage(imgList: imgList),
      ],
    ),
  );
}

Widget toiletLocation(BuildContext context) {
  final _args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  final _place = _args['places'] as Places;
  return Container(
    alignment: Alignment.centerLeft,
    child: ListTile(
      leading: Icon(
        OMIcons.locationOn,
        color: ToiletColors.colorPurple,
        size: 36.0,
      ),
      title: Text(
        _place.vicinity,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0,
          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget time(BuildContext context) {
  final _args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  final _place = _args['places'] as Places;
  final _placeDetail = _args['places_detail'] as Places;

  return ExpansionTile(
    leading: Icon(
      Icons.access_time_sharp,
      color: ToiletColors.colorPurple,
      size: 28.0,
    ),
    title: Text(
      // _place.openingHours.periods[0].open.time,
      (() {
        if (_placeDetail.openingHours == null) {
          return "ไม่ระบุเวลาทำการ";
        } else if (_placeDetail.openingHours.open_now.toString() == 'true') {
          return "เปิดทำการ";
        } else if (_placeDetail.openingHours.open_now.toString() == 'false') {
          return "ปิดทำการ";
        }
      }()),

      style: TextStyle(
        color:
            // Colors.black,
            _placeDetail.openingHours == null ||
                    _placeDetail.openingHours.open_now.toString() == 'false'
                ? Colors.red
                : Colors.green,
        fontSize: 13.0,
        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
        fontWeight: FontWeight.w700,
      ),
    ),
    trailing: Icon(Icons.keyboard_arrow_down,
        color: ToiletColors.colorPurple, size: 35.0),
    backgroundColor: Colors.white,
    children: [
      Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(72, 0, 60, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[0] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[0] != null) {
                  return _placeDetail.openingHours.weekday_text[0];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[1] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[1] != null) {
                  return _placeDetail.openingHours.weekday_text[1];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[2] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[2] != null) {
                  return _placeDetail.openingHours.weekday_text[2];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[3] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[3] != null) {
                  return _placeDetail.openingHours.weekday_text[3];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[4] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[4] != null) {
                  return _placeDetail.openingHours.weekday_text[4];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[5] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[5] != null) {
                  return _placeDetail.openingHours.weekday_text[5];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekday_text[6] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekday_text[6] != null) {
                  return _placeDetail.openingHours.weekday_text[6];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 13.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      )
    ],
  );
}

Widget info(BuildContext context) {
  return Container(
      alignment: Alignment.center,
      child: ListTile(
        leading: Icon(
          OMIcons.info,
          color: ToiletColors.colorPurple,
          size: 29.0,
        ),
        title: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 30.0,
                child: RaisedButton(
                  color: ToiletColors.colorButton,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Icon(
                    Icons.smoking_rooms_rounded,
                    color: ToiletColors.colorText,
                  ),
                  elevation: 2,
                ),
              ),
              SizedBox(width: 13.0),
              Container(
                width: 50.0,
                height: 30.0,
                child: RaisedButton(
                  color: ToiletColors.colorButton,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Icon(
                    Icons.accessible,
                    color: ToiletColors.colorText,
                  ),
                  elevation: 2,
                ),
              ),
              SizedBox(width: 13.0),
              Container(
                width: 50.0,
                height: 30.0,
                child: RaisedButton(
                  color: ToiletColors.colorButton,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Icon(
                    Icons.wc,
                    color: ToiletColors.colorText,
                  ),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
      ));
}
