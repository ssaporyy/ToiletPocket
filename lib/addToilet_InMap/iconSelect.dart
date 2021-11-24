

import 'package:flutter/material.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

class SelectIcon extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _SelectIconState();
}

class _SelectIconState extends State<SelectIcon> {
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
        padding: const EdgeInsets.only(left: 3),
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
              fontSize: 10,
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
      body: Row(
        children: <Widget>[
          Wrap(direction: Axis.vertical,
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
