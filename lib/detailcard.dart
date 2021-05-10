import 'package:flutter/material.dart';

class Toiletcard {
  final String image;
  final String name;
  final String detail;

  Toiletcard(this.image, this.name, this.detail);
}

class DetailCard extends StatelessWidget {
  List listdetail = [
    Toiletcard(
        'https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg',
        'Toilet Name 1',
        'Address'),
    Toiletcard(
        'https://media4.s-nbcnews.com/i/newscms/2020_26/1583450/public-restroom-corona-kb-main-200623_9519eb6bd31f5da24860f90cb8fc60af.jpg',
        'Toilet Name 2',
        'Address'),
    Toiletcard(
        'https://whyy.org/wp-content/uploads/2020/04/bigstock-Toilet-Shot-In-Detail-In-A-Whi-236077285.jpg',
        'Toilet Name 3',
        'Address'),
    Toiletcard(
        'https://media.architecturaldigest.com/photos/56cce09bd2db26483dc7f7b0/2:1/w_5398,h_2699,c_limit/Master%20Bathroom%20-%20Shower%20View%20-After.jpg',
        'Toilet Name 4',
        'Address'),
    Toiletcard(
        'https://www.thespruce.com/thmb/uGGY19t5PZ323A0ANVSQjrviHgY=/1820x1365/smart/filters:no_upscale()/remodel-small-bathrooms-efficiently-1821379-hero-366429e654034a0e9713ea5e27f3186b.jpg',
        'Toilet Name 5',
        'Address'),
    Toiletcard(
        'https://www.smarthomesounds.co.uk/wp/wp-content/uploads/2019/07/In-celing-1-1410x650.jpg',
        'Toilet Name 6',
        'Address'),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
          Column(
              children: listdetail
                  .map(
                    (e) => Container(
                      // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      margin:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(3, 4))
                        ],
                      ),
                      child:

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.23,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  color: Colors.blueGrey,
                                  width: 150,
                                  height: 130,
                                  child: Image.network(e.image,fit: BoxFit.fill),
                                  // Icon(Icons.cake, color: Colors.white),
                                ),
                                SizedBox(width: 11),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(e.name),
                                      Text(e.detail,
                                          style: TextStyle(color: Colors.grey)),

                                       Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // Text('Address\n',),
                                        SizedBox(height: 40,),
                                        SizedBox(
                                          height: 20,
                                          width: 42,
                                          child: RaisedButton(
                                                color: Colors.blue[100],
                                                onPressed: () {},
                                                shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30),),
                                                child: Icon(Icons.wc,size: 15,),
                                                ),
                                        ),
                                          SizedBox(width: 5,),
                                          SizedBox(
                                            height: 20,
                                            width: 42,
                                            child: RaisedButton(
                                              color: Colors.blue[100],
                                              onPressed: () {},
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30),),
                                              child: Icon(Icons.smoking_rooms,size: 15,),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                // Icon(Icons.arrow_forward_ios,
                                //     color: Colors.grey),
                                IconButton(
                                    icon: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                    onPressed: (){
                                      Navigator.pushNamed(context, '/');
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
