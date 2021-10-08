// import 'dart:async';

import 'package:ToiletPocket/blocs/application_bloc.dart';
// import 'package:ToiletPocket/models/place.dart';
// import 'package:ToiletPocket/models/place_response.dart';
// import 'package:ToiletPocket/models/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _locationController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ]),
            child: TextField(
              controller: _locationController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'ค้นหาห้องน้ำ',
                /*'Search',*/
                hintStyle: TextStyle(
                    fontSize: 15.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                suffixIcon: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/four');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(user == null
                              ? 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                              : (user.photoURL)), // NetworkImage(
                          //     'https://pbs.twimg.com/media/E1zDPp6VIAIna9y?format=jpg&name=large'),
                          // AssetImage('images/ruto.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onChanged: (value) => applicationBloc.searchPlaces(value),
              // onTap: () => applicationBloc.clearSelectedLocation(),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (applicationBloc.searchResults != null &&
            applicationBloc.searchResults.length != 0)
          Container(
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.white,
                // .withOpacity(.6),
                // backgroundBlendMode: BlendMode.darken
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ]),
            child: ListView.separated(
              itemCount: applicationBloc.searchResults.length,
              // itemCount: 0,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    applicationBloc
                        // .searchResults[index].name,
                        .searchResults[index]
                        .description,
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    applicationBloc.setSelectedLocation(
                        applicationBloc.searchResults[index].placeId);
                    // applicationBloc.setSelectedLocation(
                    //     applicationBloc.searchResults[index].placeId);

                    setState(() {});
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          )
      ],
    );
  }
}
