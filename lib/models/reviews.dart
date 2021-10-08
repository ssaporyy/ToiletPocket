class Reviews {
  final String authorName;
  final String authorUrl;
  final String language;
  final String profilePhotoUrl;
  final num rating;
  final String relative_time_description;
  final String text;
  final num time;

  Reviews({this.authorName, this.authorUrl, this.language, this.profilePhotoUrl, this.rating, this.relative_time_description, this.text, this.time});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      authorName: json['author_name'] != null ? json['author_name'] : false,
      authorUrl: json['author_url'] != null ? json['author_url'] : false,
      language: json['language'] != null ? json['language'] : false,
      profilePhotoUrl: json['profile_photo_url'] != null ? json['profile_photo_url'] : false,
      rating: json['rating'] != null ? json['rating'] : false,
      relative_time_description: json['relative_time_description'] != null ? json['relative_time_description'] : false,
      text: json['text'] != null ? json['text'] : false,
      time: json['time'] != null ? json['time'] : false,
    );
  }
}