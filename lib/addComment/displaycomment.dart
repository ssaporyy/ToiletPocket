import 'dart:io';

import 'package:ToiletPocket/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  List<File> _image = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment")),
      body: 
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
                                              // "ชื่อ",
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
                                              // "แสดงความคิดเห็น",

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
                                              snapshot.data.docs[index]
                                                          ['placeId'] ==
                                                      null
                                                  ? 'no'
                                                  : snapshot.data.docs[index]
                                                      ['placeId'],
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
                                                                        image: imageList[index] ==
                                                                                []
                                                                            ? Text(
                                                                                'data')
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
    
    );
  }
}
