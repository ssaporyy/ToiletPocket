import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/models/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
// import 'package:toiletpocket/CarouselWithDotsPage.dart';

Widget rate(BuildContext context) {
  final _args =
      ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
  final _place = _args['places'] as Places;
  return Container(
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          comment(context),
          // comment(context),
          // comment(context),
          // comment(context),
          // comment(context),
        ]),
      )
    ]),
  );
}

Widget comment(BuildContext context) {
  final _args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  final _place = _args['places'] as Places;
  final _placeDetail = _args['places_detail'] as Places;
  if (_placeDetail.reviews.isEmpty) {
    return Container(height: 200,child: Center(
      child: Text( "ไม่มีความคิดเห็น",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      fontWeight: FontWeight.w500,
                    ),),
    ),);
  }
  return Card(
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
                        // NetworkImage(
                        //     'https://cdn.readawrite.com/articles/1821/1820201/thumbnail/large.gif?3'),
                        // AssetImage('images/ruto.jpg'),

                        NetworkImage(_placeDetail.reviews.isEmpty
                            ? 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                            : '${_placeDetail.reviews[0].profile_photo_url}'),
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
                              : _placeDetail.reviews[0].rating.toDouble(),
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
                          // "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
                          _placeDetail.reviews.isEmpty
                              ? ''
                              : _placeDetail
                                  .reviews[0].relative_time_description,
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
                      _placeDetail.reviews.isEmpty
                          ? 'No name'
                          : _placeDetail.reviews[0].author_name,
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
                      _placeDetail.reviews.isEmpty
                          ? 'No Comment'
                          : _placeDetail.reviews[0].text,
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
                    //Google map ไม่ให้ดึงรูปในคอมเม้นออกมา
                    // GridView.count(
                    //   shrinkWrap: true,
                    //   primary: false,
                    //   padding: const EdgeInsets.all(4),
                    //   crossAxisSpacing: 4,
                    //   mainAxisSpacing: 4,
                    //   crossAxisCount: 3,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(0),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(5),
                    //         child:
                    //             // Image.network(
                    //             //   "https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg",
                    //             Image.asset(
                    //           'images/toilets/1.jpg',
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.all(0),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(5),
                    //         child:
                    //             // Image.network(
                    //             //   'https://media4.s-nbcnews.com/i/newscms/2020_26/1583450/public-restroom-corona-kb-main-200623_9519eb6bd31f5da24860f90cb8fc60af.jpg',
                    //             Image.asset(
                    //           'images/toilets/2.jpg',
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: const EdgeInsets.all(0),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(5),
                    //         child:
                    //             // Image.network(
                    //             //   'https://www.smarthomesounds.co.uk/wp/wp-content/uploads/2019/07/In-celing-1-1410x650.jpg',
                    //             Image.asset(
                    //           'images/toilets/3.jpg',
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget user() {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: CircleAvatar(
      backgroundImage: NetworkImage(
          'https://cdn.readawrite.com/articles/1821/1820201/thumbnail/large.gif?3'),
      radius: 30,
    ),
  );
}

Widget star() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.star, color: Colors.amber),
      Icon(Icons.star, color: Colors.amber),
      Icon(Icons.star, color: Colors.amber),
      Icon(Icons.star, color: Colors.black87),
      Icon(Icons.star, color: Colors.black87),
    ],
  );
}

Widget nameAndreview() {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          // verticalDirection: VerticalDirection.down,
          children: [
        Text(
          "Watanabe Haruto",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            fontWeight: FontWeight.w500,
          ),
        )
      ]));
}

Widget picture() {
  return Row(
    children: [
      Container(
        // width: double.infinity,
        // height: double.infinity,
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            "https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 10),
      Container(
        // width: double.infinity,
        // height: double.infinity,
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            'https://whyy.org/wp-content/uploads/2020/04/bigstock-Toilet-Shot-In-Detail-In-A-Whi-236077285.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 10),
      Container(
        // width: double.infinity,
        // height: double.infinity,
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            'https://media4.s-nbcnews.com/i/newscms/2020_26/1583450/public-restroom-corona-kb-main-200623_9519eb6bd31f5da24860f90cb8fc60af.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}
