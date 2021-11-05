import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
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
                        return Container(
                          child: ListTile(
                            leading: Container(
                              child: CircleAvatar(
                                radius: 15,
                                child: document['imgURL'] != null
                                    ? Image.network(
                                        document['imgURL'],
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
                            subtitle:
                                Text('comment = ' + document['usercomment']),
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
