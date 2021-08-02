// import 'package:ToiletPocket/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class customRadio2 extends StatefulWidget {
//   @override
//   customRadio2State createState() => new customRadio2State();
// }

// class customRadio2State extends State<customRadio2> {
//   List<bool> _isSelected = [false, false, false];
//   // String result = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ToggleButtons(
//         children: <Widget>[
//           Icon(Icons.smoking_rooms_rounded),
//           Icon(Icons.accessible),
//           Icon(Icons.wc),
//         ],
//         isSelected: _isSelected,
//         onPressed: (int index) {
//           setState(() {
//             _isSelected[index] = !_isSelected[index];
//             if (_isSelected == [true, false, false]) {
//               return 'smoking';
//             }
//           });
//         },
//         // region example 1
//         color: Colors.grey,
//         selectedColor: Colors.white,
//         fillColor: ToiletColors.colorBackground,
//         // endregion
//         // region example 2
//         borderColor: Colors.deepPurple[100],
//         selectedBorderColor: Colors.deepPurple[200],
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         // endregion
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class SelectMulti extends StatefulWidget {
//   SelectMulti({Key key, this.title}) : super(key: key);

//   // final String title;

//   @override
//   _SelectMultiState createState() => _SelectMultiState();
// }

// class _SelectMultiState extends State<SelectMulti> {
// List<String> programmingList = [
//   "Fluuter Tutorial",
//   "Java",
//   "PHP",
//   "C++",
//   "C"
// ];

// List<String> selectedProgrammingList = List();

// _showDialog() {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         //Here we will build the content of the dialog
//         return

//         AlertDialog(
//           title: Text("Flutter Choice Chip"),
//           content:

//           MultiSelectChip(
//             programmingList,
//             onSelectionChanged: (selectedList) {
//               setState(() {
//                 selectedProgrammingList = selectedList;

//                 print(selectedProgrammingList);
//               });
//             },
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text("Report"),
//               onPressed: () => Navigator.of(context).pop(),
//             )
//           ],
//         );
//       });
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           RaisedButton(
//             child: Text("Multi Select Chip Click"),
//             onPressed: () => _showDialog(),
//           ),
//           Text(selectedProgrammingList.join(", ")),
//         ],
//       ),
//     ),
//   );
// }

// }

// class MultiSelectChip extends StatefulWidget {
//   final List<String> reportList;
//   final Function(List<String>) onSelectionChanged;

//   MultiSelectChip(this.reportList, {this.onSelectionChanged});

//   @override
//   _MultiSelectChipState createState() => _MultiSelectChipState();
// }

// class _MultiSelectChipState extends State<MultiSelectChip> {

//   List<String> selectedChoices = List();

//   _buildChoiceList() {
//     List<Widget> choices = List();

//     widget.reportList.forEach((item) {
//       choices.add(Container(
//         padding: const EdgeInsets.all(2.0),
//         child: ChoiceChip(
//           label: Text(item),
//           selected: selectedChoices.contains(item),
//           onSelected: (selected) {
//             setState(() {
//               selectedChoices.contains(item)
//                   ? selectedChoices.remove(item)
//                   : selectedChoices.add(item);
//               widget.onSelectionChanged(selectedChoices);
//             });
//           },
//         ),
//       ));
//     });

//     return choices;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: _buildChoiceList(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SelectMulti extends StatefulWidget {
  //
  final String title = 'Wrap Widget & Chips';

  @override
  State<StatefulWidget> createState() => _SelectMultiState();
}

class _SelectMultiState extends State<SelectMulti> {
  List<Company> _companies;
  List<String> _filters;

  @override
  void initState() {
    _filters = <String>[];
    _companies = <Company>[
      //Men’s room
      const Company('ห้องน้ำชาย'),
      //Ladies’ room
      const Company('ห้องน้ำหญิง'),
      //disabled toilet
      const Company('ห้องน้ำสำหรับผู้พิการ'),
      //Smoking Area
      const Company('เขตสูบบุหรี่'),
    ];

  }

  Iterable<Widget> get companyWidgets sync* {
    for (Company company in _companies) {
      yield Padding(
        padding: const EdgeInsets.only(left: 5),
        child: FilterChip(
          avatar: CircleAvatar(backgroundColor: Colors.transparent,
            child: 
           Image.asset('images/flush.png'),
            // Text(
            //   company.name[0].toUpperCase(),
            //   style: TextStyle(
            //     color: Colors.white,
            //     // fontWeight: FontWeight.w600,
            //     fontSize: 15,
            //     fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            //   ),
            // ),
          ),
          label: Text(
            company.name,
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.w600,
              fontSize: 13,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            ),
          ),
          selected: _filters.contains(company.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(company.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == company.name;
                });
              }
              print('Selected: ${_filters.join(', ')}');
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Wrap(
            children: companyWidgets.toList(),
          ),
          // Text('Selected: ${_filters.join(', ')}'),
        ],
      ),
    );
  }
}

class Company {
  const Company(this.name);
  final String name;
}
