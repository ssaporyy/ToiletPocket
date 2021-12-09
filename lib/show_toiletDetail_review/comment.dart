import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentToiletDetail extends StatefulWidget {
  const CommentToiletDetail({ Key key }) : super(key: key);

  @override
  _CommentToiletDetailState createState() => _CommentToiletDetailState();
}

class _CommentToiletDetailState extends State<CommentToiletDetail> {
  @override
  Widget build(BuildContext context) {
      final _args =
      ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
  final _placeDetail = _args['places_detail'] as Places;
  final arguments = ModalRoute.of(context).settings.arguments as Map;
 if (_placeDetail.reviews.isEmpty) {
    return Container(
      alignment: Alignment.topCenter,
      height: 260,
      child: Center(
        child: Text(
          "ไม่มีความคิดเห็น",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  return 
  Column(
    children: [
    Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _placeDetail.reviews.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: new EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
            child: new Card(
              elevation: 6,
              shadowColor: ToiletColors.colorBackground,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                            child: CircleAvatar(
                              backgroundImage:

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RatingBarIndicator(
                                    rating: _placeDetail.reviews.isEmpty
                                        ? 0.0
                                        : _placeDetail.reviews[index].rating
                                            .toDouble(),
                                    itemBuilder: (context, index) =>
                                        Icon(Icons.star, color: Colors.amber),
                                    itemCount: 5,
                                    itemSize: 25.0,
                                    direction: Axis.horizontal,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    _placeDetail.reviews.isEmpty
                                        ? ''
                                        : _placeDetail.reviews[index]
                                            .relativeTimeDescription,
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
                                _placeDetail.reviews.isEmpty
                                    ? 'No name'
                                    : _placeDetail.reviews[index].authorName,
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
                                _placeDetail.reviews.isEmpty
                                    ? 'No Comment'
                                    : _placeDetail.reviews[index].text,
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
    Container(
        child: Row(
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("comment").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Flexible(
                    child: Container(
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final imageList =
                            snapshot.data.docs[index]['imgAddcomment'] as List;
                        return new Container(
                          padding: new EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
                          child: new Card(
                            elevation: 6,
                            shadowColor: ToiletColors.colorBackground,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 0,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 20, 0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              snapshot
                                                          .data
                                                          .docs[index]
                                                              ['imgprofileURL']
                                                          .toString() !=
                                                      'null'
                                                  ? '${snapshot.data.docs[index]['imgprofileURL']}'
                                                  : 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar',
                                            ),
                                            radius: 20,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                RatingBarIndicator(
                                                  rating: snapshot.data
                                                      .docs[index]['rating'],
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                          Icons.star,
                                                          color: Colors.amber),
                                                  itemCount: 5,
                                                  itemSize: 25.0,
                                                  direction: Axis.horizontal,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  snapshot.data.docs[index]
                                                      ['time'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                    fontFamily:
                                                        'Sukhumvit' ?? 'SF-Pro',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.data
                                                      .docs[index]['userName']
                                                      .toString()
                                                      .isEmpty
                                                  ? 'Name'
                                                  : snapshot.data.docs[index]
                                                      ['userName'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontFamily:
                                                    'Sukhumvit' ?? 'SF-Pro',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(

                                              snapshot.data.docs[index]
                                                  ['usercomment'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily:
                                                    'Sukhumvit' ?? 'SF-Pro',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              arguments['placeid'] == null ?'no':arguments['placeid'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontFamily:
                                                    'Sukhumvit' ?? 'SF-Pro',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                                height: 100.0,
                                                padding:
                                                    EdgeInsets.only(left: 0.0),
                                                child: ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 15.0,
                                                          top: 10.0,
                                                          bottom: 10.0),
                                                      child: Container(
                                                        width: 100.0,
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                color: Colors
                                                                    .black12,
                                                                image:
                                                                    DecorationImage(
                                                                        image: imageList[index] == []
                                                                            ? Text('data')
                                                                            : NetworkImage(imageList[index]
                                                                                .toString()),

                                                                        fit: BoxFit
                                                                            .cover),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 5.0,
                                                                color: Colors
                                                                    .black38,
                                                              )
                                                            ]),
                                                      ),
                                                    );
                                                  },
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: imageList.length,
                                                  shrinkWrap: true,
                                                  addAutomaticKeepAlives: true,
                                                )),
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
                    )),
                  );
                }
              },
            ),
          ],
        ),
      ),
    
    ],
  );
  
  }
}