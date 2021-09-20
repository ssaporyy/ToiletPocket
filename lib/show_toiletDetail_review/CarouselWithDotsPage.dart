import 'package:ToiletPocket/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithDotsPage extends StatefulWidget {
  List<String> imgList;

  CarouselWithDotsPage({this.imgList});

  @override
  _CarouselWithDotsPageState createState() => _CarouselWithDotsPageState();
}

class _CarouselWithDotsPageState extends State<CarouselWithDotsPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map((item) => Container(
          width: 400,height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 400,
                      height: 250,
                    ),
                    //เงารูป
                    // Positioned(
                    //   bottom: 0.0,
                    //   left: 0.0,
                    //   right: 0.0,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromARGB(50, 0, 0, 0),
                    //           Color.fromARGB(0, 0, 0, 0),
                    //         ],
                    //         begin: Alignment.bottomCenter,
                    //         end: Alignment.topCenter,
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 20,
                    //       vertical: 10,
                    //     ),
                    //     // child: Text(
                    //     //   'No. ${widget.imgList.indexOf(item)} image',
                    //     //   style: TextStyle(
                    //     //     color: Colors.white,
                    //     //     fontSize: 20.0,
                    //     //     fontWeight: FontWeight.bold,
                    //     //   ),
                    //     // ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ))
        .toList();

    return Column(
      children: [
        //ใส่ข้อความบนสุด
        // Padding(
        //   padding: EdgeInsets.all(20),
        //   child: Text(
        //     "Text",
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 20.0,
        //       fontFamily: 'Sukhumvit' ?? 'SF-Pro',
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // ),
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                //สี dot
                    // ? Color.fromRGBO(0, 0, 0, 0.9)
                    // : Color.fromRGBO(0, 0, 0, 0.4),
                    ? ToiletColors.colorPurple
                    : ToiletColors.colorBackground
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
