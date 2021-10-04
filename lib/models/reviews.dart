class Reviews {
  final String author_name;
  final String author_url;
  final String language;
  final String profile_photo_url;
  final num rating;
  final String relative_time_description;
  final String text;
  final num time;

  Reviews({this.author_name, this.author_url, this.language, this.profile_photo_url, this.rating, this.relative_time_description, this.text, this.time});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      author_name: json['author_name'] != null ? json['author_name'] : false,
      author_url: json['author_url'] != null ? json['author_url'] : false,
      language: json['language'] != null ? json['language'] : false,
      profile_photo_url: json['profile_photo_url'] != null ? json['profile_photo_url'] : false,
      rating: json['rating'] != null ? json['rating'] : false,
      relative_time_description: json['relative_time_description'] != null ? json['relative_time_description'] : false,
      text: json['text'] != null ? json['text'] : false,
      time: json['time'] != null ? json['time'] : false,
    );
  }
}