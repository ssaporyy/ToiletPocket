import 'package:ToiletPocket/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class customRadio extends StatefulWidget {
  @override
  _customRadioState createState() => _customRadioState();
}

class _customRadioState extends State<customRadio> {

  List<String> lst = ['ไม่เสียค่าใช้บริการ','เสียค่าใช้บริการ'];
  int selectedIndex = 0;

  List<IconData> iconList = [Icons.settings, Icons.bookmark, Icons.account_circle];
  int secondaryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customRadio(lst[0],0),
              SizedBox(width: 10,),
              customRadio(lst[1],1),
            ],
          ),

          // SizedBox(height: 30.0,),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     customRadio2(iconList[0], 0),
          //     customRadio2(iconList[1], 1),
          //     customRadio2(iconList[2], 2),
          //   ],
          // )
        ],
      ),
    );
  }

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }
 
  Widget customRadio(String txt,int index){
    return Container(
      height: 40,
      width: 130,
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide: BorderSide(color: selectedIndex == index ? ToiletColors.colorPurple : Colors.grey,width: 2),
        child: Text(txt,style: TextStyle(color: selectedIndex == index ?ToiletColors.colorPurple : Colors.grey,fontFamily: 'Sukhumvit' ?? 'SF-Pro',fontSize: 12),),

      ),
    );
  }

  // void changeSecondaryIndex(int index){
  //   setState(() {
  //     secondaryIndex = index;
  //   });
  // }

//   Widget customRadio2(IconData icon,int index){
//     return OutlineButton(
//       onPressed: () => changeSecondaryIndex(index),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       borderSide: BorderSide(color: secondaryIndex == index ? Colors.deepOrangeAccent[700] : Colors.grey),
//       child: Icon(icon,color:  secondaryIndex == index ? Colors.deepOrangeAccent : Colors.grey,),
//     );
//   }
}