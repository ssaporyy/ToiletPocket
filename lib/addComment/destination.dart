import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/star.dart';
import 'package:flutter/material.dart';
// import 'package:outline_material_icons/outline_material_icons.dart';

class Destination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ToiletColors.colorBackground,
      body: add(context),
    );
  }
}

Widget add(BuildContext context) {
  return Stack(
    children: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.only(left: 7),
          height: 130,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        primary: Colors.black,
                        padding: EdgeInsets.all(5),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/two');
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: Colors.blue,
                          ),
                          Text(
                            'กลับ',
                            style: TextStyle(
                              color: Colors.blue,
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
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          //color of shadow
                          spreadRadius: 3, //spread radius
                          blurRadius: 9, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'มาถึง',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'ชื่อห้องน้ำ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 220,
                        margin: EdgeInsets.all(0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side:
                                  BorderSide(color: ToiletColors.colorButton2)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: <Widget>[
                                      SizedBox(height: 10,),
                                    Column(
                                      children: [
                                      Text(
                                        "รีวิวและประเมินห้องน้ำ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(height: 80, child: Star()),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 47,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            30.0)),
                                              ),
                                              child: ElevatedButton(
                                                // Within the `FirstScreen` widget
                                                style: ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                    primary: ToiletColors
                                                        .colorButton2,
                                                    elevation: 5.0),

                                                child: Image.asset(
                                                  'images/comment.png',
                                                  alignment: Alignment.center,
                                                  width: 35,
                                                ),
                                                onPressed: () {
                                                  // Navigate to the second screen using a named route.
                                                  Navigator.pushNamed(
                                                      context, '/seven');
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 47,
                                              child: ElevatedButton(
                                                // Within the `FirstScreen` widget
                                                style: ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                    primary: ToiletColors
                                                        .colorButton2,
                                                    elevation: 5.0),

                                                child: Text(
                                                  'ยืนยัน',
                                                  style: TextStyle(
                                                      fontFamily: 'Sukhumvit' ??
                                                          'SF-Pro',
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  // Navigator.of(context).pop();
                                                  Navigator.pushNamed(
                                                      context, '/two');
                                                },
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ]),
                                  ],
                                  elevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                              },
                            );
                          },
                          padding: EdgeInsets.all(10.0),
                          color: ToiletColors.colorButton2,
                          textColor: Colors.white,
                          child: Text(
                            "สิ้นสุดปลายทาง",
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'images/direction.png',
                      width: 55,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}
