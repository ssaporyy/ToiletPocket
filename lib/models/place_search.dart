class PlaceSearch{
  final String description;
  final String plceId;

  PlaceSearch({this.description, this.plceId});

  factory PlaceSearch.fromJson(Map<String, dynamic> json ){
    return PlaceSearch(
      description: json['description'],
      plceId: json['place_id']
      );
  }
}