class NewsModel {
  String title;
  String description;

  NewsModel({this.title = '', this.description = ''});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
