import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Container(
              child: FloatingSearchBar(
                borderRadius: BorderRadius.circular(30),
                hint: 'Search.....',
                openAxisAlignment: 0.0,
                //maxWidth: 600,
                axisAlignment: 0.0,
                scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
                elevation: 4.0,
                physics: BouncingScrollPhysics(),
                onQueryChanged: (query) {
                  //Your methods will be here
                },
                //showDrawerHamburger: false,
                transitionCurve: Curves.easeInOut,
                transitionDuration: Duration(milliseconds: 500),
                transition: CircularFloatingSearchBarTransition(),
                debounceDelay: Duration(milliseconds: 500),
                actions: [
                  FloatingSearchBarAction(
                    showIfOpened: false,
                    child: CircularButton(
                      icon: Icon(Icons.place),
                      onPressed: () {
                        print('Places Pressed');
                      },
                    ),
                  ),
                  FloatingSearchBarAction.searchToClear(
                    showIfClosed: false,
                  ),
                ],
                builder: (context, transition) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Material(
                      color: Colors.white,
                      //แสดงคำ(เคย)ที่เสิร์จ
                      // child: Container(
                      //   height: 200.0,
                      //   color: Colors.white,
                      //   child: Column(
                      //     children: [
                      //       ListTile(
                      //         title: Text('Home'),
                      //         subtitle: Text('more info here........'),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 120, horizontal: 10),
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
                  .map((e) =>
                  Container(
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

          ],
        ),
      ),

    );
  }
}


