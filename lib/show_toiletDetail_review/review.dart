import 'package:ToiletPocket/colors.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
// import 'package:toiletpocket/CarouselWithDotsPage.dart';


Widget rate(BuildContext context) {
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
          SizedBox(
            width: 25),
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: <Widget>[
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "4.7",
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber,size: 20,),
                      Icon(Icons.star, color: Colors.amber,size: 20),
                      Icon(Icons.star, color: Colors.amber,size: 20),
                      Icon(Icons.star, color: Colors.black87,size: 20),
                      Icon(Icons.star, color: Colors.black87,size: 20),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "(573)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
              Container(
                child: Text(
                  "ดี",
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
        child: Column(children: [
          comment(context),
          comment(context),
          comment(context),
          comment(context),
          comment(context),
        ]),
      )
    ]),
  );
}

Widget comment(BuildContext context) {
  return 
         Card(
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
                  child: Container(padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                    child: CircleAvatar(
                      backgroundImage: 
                      // NetworkImage(
                      //     'https://cdn.readawrite.com/articles/1821/1820201/thumbnail/large.gif?3'),
                      AssetImage('images/ruto.jpg'),
                      radius: 22,
                    ),
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: Colors.amber,size: 20),
                          Icon(Icons.star, color: Colors.amber,size: 20),
                          Icon(Icons.star, color: Colors.amber,size: 20),
                          Icon(Icons.star, color: Colors.black87,size: 20),
                          Icon(Icons.star, color: Colors.black87,size: 20),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Watanabe Haruto",
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
                        "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
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

                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(4),
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        crossAxisCount: 3,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: 
                              // Image.network(
                              //   "https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg",
                                Image.asset('images/toilets/1.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: 
                              // Image.network(
                              //   'https://media4.s-nbcnews.com/i/newscms/2020_26/1583450/public-restroom-corona-kb-main-200623_9519eb6bd31f5da24860f90cb8fc60af.jpg',
                              Image.asset('images/toilets/2.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: 
                              // Image.network(
                              //   'https://www.smarthomesounds.co.uk/wp/wp-content/uploads/2019/07/In-celing-1-1410x650.jpg',
                                Image.asset('images/toilets/3.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
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
