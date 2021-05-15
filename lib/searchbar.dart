import 'package:ToiletPocket/detailcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 180),
        child: Stack(
          children: <Widget>[
            // Container(
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //     begin: Alignment.topRight,
            //     end: Alignment.bottomLeft,
            //     colors: [
            //       Colors.deepPurple[200],
            //       Colors.lightBlue[200],
            //     ],
            //   )),
            //   // Background
            //   child: Center(
            //     child: 
            //     // TextField(
            //       Text(
            //       "Search",

            //       style: TextStyle(
            //           fontSize: 25.0,
            //           fontWeight: FontWeight.w600,
            //           fontFamily: 'Poppins',
            //           color: Colors.white),
            //     ),
            //   ),
            //   // color: Colors.deepPurple[100],
            //   height: height + 85,
            //   width: MediaQuery.of(context).size.width,
            // ),
            Positioned(
              // To take AppBar Size only
              top: 115.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/');
                  },
                ),
                primary: false,
                title: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18))),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black54),
                    onPressed: () {},
                  ),
                ],
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170),
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                // margin: EdgeInsets.only(top: 0,left: 15),
                margin: EdgeInsets.only(left: 15),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    'toilet',
                    'Most toilet',
                    'near toilet',
                    'toilet 1',
                    'toilet 1',
                    'Etc...'
                  ]
                      .map((e) => Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Opacity(
                              opacity: 0.6,
                              child: RaisedButton(
                                color: Colors.white,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(e),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(AppBar().preferredSize.height),
      // body: DetailCard(),
    );
  }

}
