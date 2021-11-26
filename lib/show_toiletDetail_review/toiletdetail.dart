import 'package:ToiletPocket/Show_toiletDetail_review/CarouselWithDotsPage.dart';
// import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
// import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/show_toiletDetail_review/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:getwidget/components/carousel/gf_items_carousel.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
// import 'package:provider/provider.dart';

class ToiletDetail extends StatefulWidget {
  ToiletDetail({Key key}) : super(key: key);

  @override
  ToiletDetailState createState() => ToiletDetailState();
}

class ToiletDetailState extends State<ToiletDetail> {
  @override
  Widget build(BuildContext context) {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    final _args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
    final _place = _args['places'] as Places;
    final _placeDetail = _args['places_detail'] as Places;
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            // appBar: back(context),
            Stack(
          children: <Widget>[
            // back(context),
            // appbar(context),
            Scaffold(
              backgroundColor: ToiletColors.colorBackground,
              body: Container(
                child: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: 0.0, left: 13.0, right: 0.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 40.0),
                        child: InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, '/two');
                            Navigator.of(context).pop();
                            // Navigator.pop(context);
                          },
                          child: IgnorePointer(
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Container(
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
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            ),
                            //you can set more BoxShadow() here
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 27),
                          // child: slide(context)
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
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
                                // rate(context),

                                Container(
                                  child: Column(children: [
                                    Container(
                                      color: ToiletColors.colorgrayOpacity,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Row(children: [
                                        Container(
                                          child: Column(children: [
                                            Image(
                                              width: 30,
                                              height: 30,
                                              image:
                                                  AssetImage('images/star.png'),
                                            ),
                                            Text(
                                              "คะแนน",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14.0,
                                                fontFamily:
                                                    'Sukhumvit' ?? 'SF-Pro',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        SizedBox(width: 25),
                                        Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "${_place.rating}",
                                                          // "4.7",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16.0,
                                                            fontFamily:
                                                                'Sukhumvit' ??
                                                                    'SF-Pro',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: RatingBarIndicator(
                                                      rating: _place.rating,
                                                      itemBuilder: (context,
                                                              index) =>
                                                          Icon(Icons.star,
                                                              color:
                                                                  Colors.amber),
                                                      itemCount: 5,
                                                      itemSize: 21.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          '(${_place.userRatingCount})',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16.0,
                                                              fontFamily:
                                                                  'Sukhumvit' ??
                                                                      'SF-Pro',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                                Container(
                                                  child: Text(
                                                    (() {
                                                      if (_place.rating ==
                                                          0.0) {
                                                        return "-";
                                                      } else if (_place
                                                              .rating <=
                                                          1.0) {
                                                        return "แย่";
                                                      } else if (_place
                                                              .rating <=
                                                          2.0) {
                                                        return "ควรปรับปรุง";
                                                      } else if (_place
                                                              .rating <=
                                                          3.0) {
                                                        return "พอใช้";
                                                      } else if (_place
                                                              .rating <=
                                                          4.0) {
                                                        return "ดี";
                                                      } else if (_place
                                                              .rating <=
                                                          5.0) {
                                                        return "ดีเยี่ยม";
                                                      }
                                                    }()),
                                                    // "ดี",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontFamily: 'Sukhumvit' ??
                                                          'SF-Pro',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ]),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("comment")
                                                .orderBy('time',
                                                    descending: true)
                                                .snapshots()
                                                ,
                                            builder: (context,
                                                // AsyncSnapshot<QuerySnapshot>
                                                AsyncSnapshot<QuerySnapshot<Object>>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              if (snapshot.hasError) {
                                                return new Text(
                                                    'Error: ${snapshot.hasError}');
                                              } else {
                                                return Flexible(
                                                  child: Container(
                                                      child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .data.docs.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final imageList = snapshot.data.docs[index]['imgAddcomment'] as List;
                                                      if (_place.placeId ==
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['placeId']) {
                                                        return new Container(
                                                          padding:
                                                              new EdgeInsets
                                                                      .fromLTRB(
                                                                  8.0,
                                                                  5.0,
                                                                  8.0,
                                                                  0.0),
                                                          child: Card(
                                                            elevation: 6,
                                                            shadowColor:
                                                                ToiletColors
                                                                    .colorBackground,
                                                            child: Container(
                                                              // height: 260,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        flex: 0,
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              15,
                                                                              0,
                                                                              20,
                                                                              0),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundImage:
                                                                                NetworkImage(
                                                                                  // 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                                                                              snapshot.data.docs[index]['imgprofileURL'] != null ? '${snapshot.data.docs[index]['imgprofileURL']}' : 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar',
                                                                            ),
                                                                            radius:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            Row(
                                                                              children: <Widget>[
                                                                                RatingBarIndicator(
                                                                                  rating: snapshot.data.docs[index]['rating'],
                                                                                  itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                                                                                  itemCount: 5,
                                                                                  itemSize: 25.0,
                                                                                  direction: Axis.horizontal,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 3,
                                                                                ),
                                                                                Text(
                                                                                  snapshot.data.docs[index]['time'],
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 12.0,
                                                                                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Text(
                                                                              // "Watanabe Haruto",
                                                                              snapshot.data.docs[index]['userName'] == null? 'Name' : snapshot.data.docs[index]['userName'],
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 16.0,
                                                                                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Text(
                                                                              // "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
                                                                              snapshot.data.docs[index]['usercomment'] == null?'': snapshot.data.docs[index]['usercomment'],
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14.0,
                                                                                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            if (imageList !=
                                                                                null)
                                                                              Container(
                                                                                  height: 100.0,
                                                                                  padding: EdgeInsets.only(left: 0.0),
                                                                                  child: ListView.builder(
                                                                                    // physics: NeverScrollableScrollPhysics(),
                                                                                    itemBuilder: (context, index) {
                                                                                      return Padding(
                                                                                        padding: EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          height: 100,
                                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.black12, image: DecorationImage(image: imageList == null ? '' : NetworkImage(imageList[index].toString()), fit: BoxFit.cover), shape: BoxShape.rectangle, boxShadow: [
                                                                                            BoxShadow(
                                                                                              blurRadius: 5.0,
                                                                                              color: Colors.black38,
                                                                                            )
                                                                                          ]),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    itemCount: imageList.length,
                                                                                    shrinkWrap: true,
                                                                                    addAutomaticKeepAlives: true,
                                                                                  )),
                                                                            if (imageList ==
                                                                                null)
                                                                              Container()
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return SizedBox(
                                                            height: 3);
                                                      }
                                                    },
                                                  )),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    if (_placeDetail.reviews.isNotEmpty)
                                      Column(
                                        children: [
                                          Container(
                                            child: ListView.builder(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 50),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  _placeDetail.reviews.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return new Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          8.0, 0.0, 8.0, 0.0),
                                                  child: new Card(
                                                    elevation: 6,
                                                    shadowColor: ToiletColors
                                                        .colorBackground,
                                                    child: Container(
                                                      // height: 260,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 0,
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          0,
                                                                          20,
                                                                          0),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundImage:
                                                                        // NetworkImage(
                                                                        //     'https://cdn.readawrite.com/articles/1821/1820201/thumbnail/large.gif?3'),
                                                                        // AssetImage('images/ruto.jpg'),

                                                                        NetworkImage(_placeDetail.reviews.isEmpty
                                                                            ? 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                                                                            : '${_placeDetail.reviews[index].profilePhotoUrl}'),
                                                                    radius: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        RatingBarIndicator(
                                                                          rating: _placeDetail.reviews.isEmpty
                                                                              ? 0.0
                                                                              : _placeDetail.reviews[index].rating.toDouble(),
                                                                          itemBuilder: (context, index) => Icon(
                                                                              Icons.star,
                                                                              color: Colors.amber),
                                                                          itemCount:
                                                                              5,
                                                                          itemSize:
                                                                              25.0,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              3,
                                                                        ),
                                                                        Text(
                                                                          // "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
                                                                          _placeDetail.reviews.isEmpty
                                                                              ? ''
                                                                              : _placeDetail.reviews[index].relativeTimeDescription,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                12.0,
                                                                            fontFamily:
                                                                                'Sukhumvit' ?? 'SF-Pro',
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      // "Watanabe Haruto",
                                                                      _placeDetail
                                                                              .reviews
                                                                              .isEmpty
                                                                          ? 'No name'
                                                                          : _placeDetail
                                                                              .reviews[index]
                                                                              .authorName,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontFamily:
                                                                            'Sukhumvit' ??
                                                                                'SF-Pro',
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      // "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
                                                                      _placeDetail
                                                                              .reviews
                                                                              .isEmpty
                                                                          ? 'No Comment'
                                                                          : _placeDetail
                                                                              .reviews[index]
                                                                              .text,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14.0,
                                                                        fontFamily:
                                                                            'Sukhumvit' ??
                                                                                'SF-Pro',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (_placeDetail.reviews.isEmpty)
                                      Container(
                                        alignment: Alignment.topCenter,
                                        height: 260,
                                        child: Center(
                                          child: Text(
                                            // "",
                                            "ไม่มีความคิดเห็นแล้ว",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontFamily:
                                                  'Sukhumvit' ?? 'SF-Pro',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Testpage(),
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

Widget slide(BuildContext context) {
  // final applicationBloc = Provider.of<ApplicationBloc>(context);
  final _args =
      ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
  final _place = _args['places'] as Places;
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
        Container(
          child: Column(children: [
            Container(
              color: ToiletColors.colorgrayOpacity,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Row(children: [
                Container(
                  child: Column(children: [
                    Image(
                      width: 30,
                      height: 30,
                      image: AssetImage('images/star.png'),
                    ),
                    Text(
                      "คะแนน",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.0,
                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: 25),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${_place.rating}",
                                  // "4.7",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: RatingBarIndicator(
                              rating: _place.rating,
                              itemBuilder: (context, index) =>
                                  Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 21.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '(${_place.userRatingCount})',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        ]),
                        Container(
                          child: Text(
                            (() {
                              if (_place.rating == 0.0) {
                                return "-";
                              } else if (_place.rating <= 1.0) {
                                return "แย่";
                              } else if (_place.rating <= 2.0) {
                                return "ควรปรับปรุง";
                              } else if (_place.rating <= 3.0) {
                                return "พอใช้";
                              } else if (_place.rating <= 4.0) {
                                return "ดี";
                              } else if (_place.rating <= 5.0) {
                                return "ดีเยี่ยม";
                              }
                            }()),
                            // "ดี",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ]),
                ),
              ]),
            ),
            Container(
              child: CommentToiletDetail(),
              // child: comment(context)
            )
          ]),
        ),
      ],
    ),
  );
}

Widget img(BuildContext context) {
  final _args =
      ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
  // final _place = _args['places'] as Places;
  final _placeDetail = _args['places_detail'] as Places;
  var imgList = new List<String>.generate(
    _placeDetail.photos.length,
    (index) =>
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${_placeDetail.photos[index].photoReference}&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno',
  );
  if (imgList.isEmpty) {
    return Image.network(
      'https://www.sarras-shop.com/out/pictures/master/product/1/no-image-available-icon.jpg',
      fit: BoxFit.cover,
    );
  }
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
      ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
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
      ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
  // final _place = _args['places'] as Places;
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
        } else if (_placeDetail.openingHours.openNow.toString() == 'true') {
          return "เปิดทำการ";
        } else if (_placeDetail.openingHours.openNow.toString() == 'false') {
          return "ปิดทำการ";
        }
      }()),

      style: TextStyle(
        color:
            // Colors.black,
            _placeDetail.openingHours == null ||
                    _placeDetail.openingHours.openNow.toString() == 'false'
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
        width: 500,
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
                } else if (_placeDetail.openingHours.weekdayText[0] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[0] != null) {
                  return _placeDetail.openingHours.weekdayText[0];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.5,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekdayText[1] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[1] != null) {
                  return _placeDetail.openingHours.weekdayText[1];
                }
              }()),
              style: TextStyle(
                wordSpacing: 0.0,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekdayText[2] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[2] != null) {
                  return _placeDetail.openingHours.weekdayText[2];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.5,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[3] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[3] != null) {
                  return _placeDetail.openingHours.weekdayText[3];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.5,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekdayText[4] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[4] != null) {
                  return _placeDetail.openingHours.weekdayText[4];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.5,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekdayText[5] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[5] != null) {
                  return _placeDetail.openingHours.weekdayText[5];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.5,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              (() {
                if (_placeDetail.openingHours == null) {
                  return "";
                } else if (_placeDetail.openingHours.weekdayText[6] == null) {
                  return "ไม่ระบุเวลาทำการ";
                } else if (_placeDetail.openingHours.weekdayText[6] != null) {
                  return _placeDetail.openingHours.weekdayText[6];
                }
              }()),
              style: TextStyle(
                wordSpacing: -1.5,
                letterSpacing: 2.0,
                color: Colors.black,
                fontSize: 12.0,
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
