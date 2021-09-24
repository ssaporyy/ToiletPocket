import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

Widget boxes(
  String _image,
  double lat,
  double long,
  String toiletName,
  score,
  rating,
  address,
  testt,
  BuildContext context,
) {
  // final bool hasImage = false;
  final applicationBloc = Provider.of<ApplicationBloc>(context);
  final _place = ModalRoute.of(context)?.settings.arguments as Places;
  return Container(
    child: new FittedBox(
      fit: BoxFit.cover,
      child: Material(
          color: Colors.white,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 850,
                height: 400,
                // height: MediaQuery.of(context).size.width + 5,
                // width: MediaQuery.of(context).size.width / 3,
                child: ClipRRect(
                  borderRadius: new BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(0.0),
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      _image.isEmpty
                          ? 'https://www.familyhandyman.com/wp-content/uploads/2019/08/FH11DJA_514_52_002-Gerber-Ultra-Flush-Toilet.jpg?fit=680,680'
                          : _image,
                    ),
                    // errorBuilder: (context, exception, stackTrack) => Container(
                    //   color: ToiletColors.colorButton,
                    //   child: Icon(
                    //     Icons.collections,
                    //     size: 100,
                    //     color: ToiletColors.colorPurple,
                    //   ),
                    // ),
                  ),
                ),
              ),
              Container(
                width: 800,
                height: 450,
                // height: MediaQuery.of(context).size.width + 5,
                padding: const EdgeInsets.only(
                    bottom: 40, top: 15, left: 20, right: 20),
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: myDetailsContainer1(
                          toiletName, score, rating, address, testt),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 90,
                            width: 240,
                            child: RaisedButton(
                              color: ToiletColors.colorButton,
                              onPressed: () {
                                //กดไปหน้า นำทาง
                                // _gotoLocation(lat, long);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                  bottom: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.directions,
                                    color: ToiletColors.colorText,
                                    size: 35,
                                  ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    'เส้นทาง',
                                    style: TextStyle(
                                      color: ToiletColors.colorText,
                                      fontSize: 30.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      // fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              ),
                              elevation: 1,
                              padding: new EdgeInsets.fromLTRB(28, 7, 28, 7),
                            ),
                          ),
                          // SizedBox(width: 50.0),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 85.0,
                                  height: 80.0,
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
                                      size: 35,
                                    ),
                                    elevation: 1,
                                    padding:
                                        new EdgeInsets.fromLTRB(3, 7, 3, 7),
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Container(
                                  width: 85.0,
                                  height: 80.0,
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
                                      size: 35,
                                    ),
                                    elevation: 1,
                                    padding:
                                        new EdgeInsets.fromLTRB(3, 7, 3, 7),
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Container(
                                  width: 85.0,
                                  height: 80.0,
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
                                      size: 35,
                                    ),
                                    elevation: 1,
                                    padding:
                                        new EdgeInsets.fromLTRB(3, 7, 3, 7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}

// Widget myDetailsContainer1(String restaurantName, context, index) {
Widget myDetailsContainer1(String toiletName, score, rating, address, testt) {
  return Container(
    alignment: Alignment.topLeft,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          toiletName,
          // toiletName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff6200ee),
              fontSize: 40.0,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                RatingBarIndicator(
                  rating: rating.rating,
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 40.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  '($score)',
                  // '($score)',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 35.0,
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<double>(
                    builder: (context, meters, wiget) {
                      return (meters != null)
                          ? Text(
                              '$address',
                              // '$address',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 30.0,
                                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                  fontWeight: FontWeight.normal),
                            )
                          : Container();
                    },
                  ),
                ],
              ),
            ),
            // Container(child: Icon(Icons.directions)),
            // Container(
            //     //mi
            //     child: Text(
            //   mi,
            //   style: TextStyle(
            //     color: Colors.black54,
            //     fontSize: 30.0,
            //     fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            //   ),
            // )),
          ],
        ),
        SizedBox(height: 15.0),
        Container(
          child: new Row(
            children: <Widget>[
              Text(
                "Closed \u00B7 Opens 17:00 Thu",
                // testt,

                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 30.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(width: 50.0),
              Consumer<double>(
                builder: (context, meters, wiget) {
                  return (meters != null)
                      ? Text(
                          '\u00b7  ${(meters / 1609).round()} mi',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30.0,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              fontWeight: FontWeight.normal),
                        )
                      : Container();
                },
              ),
              // Text(
              //   "500 เมตร",
              //   style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 35.0,
              //       fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              //       fontWeight: FontWeight.normal),
              // ),
            ],
          ),
        ),
        // SizedBox(height: 5.0),
      ],
    ),
  );
}
