import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      body: Container(
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
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((document) {
                        // print('Images =');
                        // print('Images = -----------------------' +
                        //     document['imgAddcomment'].toString());
                        // List imageList = document['imgAddcomment'];
                        // List<Widget> result = snapshot.data.docs
                        //     .map((c) => Image.network(
                        //         document['imgAddcomment'].toString()))
                        //     .toList();
                        // final List img = document['imgAddcomment'];
                        // final List img = [
                        //   'https://firebasestorage.googleapis.com/v0/b/toiletpocket-pj.appspot.com/o/images%2F67faca6d-3585-4d5f-a4b6-f177beb4d5114328562372637156712.jpg?alt=media&token=e429585c-ce0e-4b9c-b350-e72ffa98025b',
                        //   ];
                        // final List img = [
                        //   'https://firebasestorage.googleapis.com/v0/b/toiletpocket-pj.appspot.com/o/images%2F67faca6d-3585-4d5f-a4b6-f177beb4d5114328562372637156712.jpg?alt=media&token=e429585c-ce0e-4b9c-b350-e72ffa98025b',
                        //   'https://firebasestorage.googleapis.com/v0/b/toiletpocket-pj.appspot.com/o/images%2F5a8e1473-4454-4359-9798-dd006300e1243959910793714610986.jpg?alt=media&token=8d3129df-8a7a-4405-8870-bc06099b385c',
                        //   'https://firebasestorage.googleapis.com/v0/b/toiletpocket-pj.appspot.com/o/images%2F84848bc5-4d54-4346-ac77-7081ebbe40956205931860320900183.jpg?alt=media&token=b2fe9d8e-57e5-4afb-b94e-68b3635f2f75'
                        // ];
                        // print('img = -----------------' + '$img');
                        // List<String> imageList = document['imgAddcomment'];
                        final imageList = document['imgAddcomment'] as List;
                        return Container(
                          child: ListTile(
                            leading: Container(
                              child: CircleAvatar(
                                radius: 15,
                                child: document['imgprofileURL'] != null
                                    ? Image.network(
                                        document['imgprofileURL'],
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'),
                              ),
                            ),
                            title: Text(document['time']
                                    .toString() /* '${formatter.format(myDatetime)}'*/ +
                                ' ' +
                                document['userName']),
                            // subtitle: Column(
                            //   children: [
                            //     Text('comment = ' + document['usercomment']),
                            //     Text('comment = ' + document['usercomment']),
                            //     Text('comment = ' + document['usercomment']),
                            //   ],
                            // ),
                            subtitle: ListView.builder(
                                shrinkWrap: true,
                                itemCount: imageList.length,
                                itemBuilder: (context, index) =>
                                    Image.network(imageList[index])
                                // Text(imageList[index] ?? ''),
                                ),
                            // Container(
                            //     height: 170.0,
                            //     padding: EdgeInsets.only(left: 10.0),
                            //     child: ListView.builder(
                            //       itemBuilder: (context, index) {
                            //         return Padding(
                            //             padding: EdgeInsets.only(
                            //                 right: 15.0,
                            //                 top: 10.0,
                            //                 bottom: 10.0),
                            //             child: Container(
                            //               width: 100.0,
                            //               decoration: BoxDecoration(
                            //                   borderRadius:
                            //                       BorderRadius.circular(
                            //                           5.0),
                            //                   color: Colors.black12,
                            //                   image: DecorationImage(
                            //                       image: NetworkImage(img.toString()),
                            //                       fit: BoxFit.cover),
                            //                   shape: BoxShape.rectangle,
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       blurRadius: 5.0,
                            //                       color: Colors.black38,
                            //                     )
                            //                   ]),
                            //             ));
                            //       },
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: 20,
                            //       addAutomaticKeepAlives: true,
                            //     )),
                            //     ListView.builder(
                            //   itemBuilder: (BuildContext ctx, int index) {
                            //     return Padding(
                            //       padding: EdgeInsets.all(20),
                            //       child: Column(
                            //         children: <Widget>[
                            //           Image.network(img[index]),
                            //           Icon(
                            //             Icons.favorite,
                            //             color: Colors.red,
                            //             size: 50,
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            //   itemCount: img.length,
                            // ),
                            // Image.network(document['imgAddcomment']),
                            // Column(children: result,),
                            // Text('comment = ' + document['usercomment']),
                            //   Column(
                            //   children: [
                            //     Expanded(
                            //       child: ListView.builder(
                            //         itemCount: img.length == null ? 0: img.length,
                            //         itemBuilder: (context, int) {
                            //           return Container(
                            //             margin: EdgeInsets.all(3),
                            //             decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                     image: NetworkImage(
                            //                         img.toString()),
                            //                     fit: BoxFit.cover)),
                            //           );
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text('comment = ' + document['usercomment']),
                            //     // Padding(
                            //     //   padding: const EdgeInsets.only(
                            //     //       left: 12, right: 12),
                            //     //   child: ListView.builder(
                            //     //       scrollDirection: Axis.horizontal,
                            //     //       itemCount: imgList.length,
                            //     //       itemBuilder:
                            //     //           (BuildContext context, int i) {
                            //     //         return Container(
                            //     //           height: 60,
                            //     //           width: 60,
                            //     //           child: Image.network(
                            //     //               '$imgList'),
                            //     //           // decoration: BoxDecoration(
                            //     //           //   border: Border.all()
                            //     //           // ),
                            //     //         );
                            //     //       }),
                            //     // )
                            //     // StaggeredGridView.countBuilder(
                            //     //   crossAxisCount: 2,
                            //     //   itemCount: ,
                            //     //   itemBuilder: (BuildContext context,
                            //     //           int index) =>
                            //     //       Container(
                            //     //           margin:
                            //     //               EdgeInsets.fromLTRB(5, 5, 5, 5),
                            //     //           child: Image(
                            //     //               fit: BoxFit.fill,
                            //     //               image: NetworkImage(
                            //     //                   document['imgAddcomment'][index]))),
                            //     //   staggeredTileBuilder: (int index) =>
                            //     //       new StaggeredTile.fit(1),
                            //     // ),
                            //   ],
                            // ),
                            // subtitle:

                            trailing: Text(document['rating'].toString()),
                          ),
                        );
                      }).toList(),
                    ),
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
