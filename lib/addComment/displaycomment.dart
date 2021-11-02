import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("comment").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Image.network(document['imgURL']),
                      ),
                    ),
                    title: Text(document['time']
                            .toString() /* '${formatter.format(myDatetime)}'*/ +
                        ' ' +
                        document['userName']),
                    subtitle: Text('comment = ' + document['usercomment']),
                    trailing: Text(document['rating'].toString()),
                  ),
                  // child: ListView(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   children: [
                  //       Container(
                  //       padding: new EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
                  //       child: new Card(
                  //         elevation: 6,
                  //         shadowColor: ToiletColors.colorBackground,
                  //         child: Container(
                  //           // height: 260,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: <Widget>[
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Expanded(
                  //                     flex: 0,
                  //                     child: Container(
                  //                       padding:
                  //                           EdgeInsets.fromLTRB(15, 0, 20, 0),
                  //                       child: CircleAvatar(
                  //                         backgroundImage:
                  //                             // NetworkImage(
                  //                             //     'https://cdn.readawrite.com/articles/1821/1820201/thumbnail/large.gif?3'),
                  //                             // AssetImage('images/ruto.jpg'),

                  //                             NetworkImage(document['imgURL']),
                  //                         radius: 20,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Expanded(
                  //                     flex: 4,
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: <Widget>[
                  //                         Row(
                  //                           children: <Widget>[
                  //                             RatingBarIndicator(
                  //                               rating:
                  //                                   document['rating'],
                  //                               itemBuilder: (context, index) =>
                  //                                   Icon(Icons.star,
                  //                                       color: Colors.amber),
                  //                               itemCount: 5,
                  //                               itemSize: 25.0,
                  //                               direction: Axis.horizontal,
                  //                             ),
                  //                             SizedBox(
                  //                               width: 3,
                  //                             ),
                  //                             Text(
                  //                               // "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
                  //                               document['usercomment'],
                  //                               style: TextStyle(
                  //                                 color: Colors.black,
                  //                                 fontSize: 12.0,
                  //                                 fontFamily:
                  //                                     'Sukhumvit' ?? 'SF-Pro',
                  //                                 fontWeight: FontWeight.w400,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         SizedBox(
                  //                           height: 5,
                  //                         ),
                  //                         Text(
                  //                           // "Watanabe Haruto",
                  //                           document['userName'],
                  //                           style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 16.0,
                  //                             fontFamily:
                  //                                 'Sukhumvit' ?? 'SF-Pro',
                  //                             fontWeight: FontWeight.w600,
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 5,
                  //                         ),
                  //                         Text(
                  //                           // "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
                  //                           document['usercomment'],
                  //                           style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 14.0,
                  //                             fontFamily:
                  //                                 'Sukhumvit' ?? 'SF-Pro',
                  //                             fontWeight: FontWeight.w500,
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 5,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
