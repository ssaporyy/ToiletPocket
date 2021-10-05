class PlaceSearch {
  final String description;
  final String placeId;
  //new
  // final String name;


  PlaceSearch({this.description, this.placeId,
  // /*new */,this.name
  });

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
      description: json['description'],
      placeId: json['place_id'],
      //new
      // name: json['formatted_address'],
    );
  }
}
