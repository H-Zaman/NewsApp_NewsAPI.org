class NewsModel {
  NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  NewsSourceModel source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    source: NewsSourceModel.fromJson(json["source"]),
    author: json["author"] ?? '',
    title: json["title"] ?? '_',
    description: json["description"] ?? '',
    url: json["url"] ?? '',
    urlToImage: json["urlToImage"] ?? '',
    publishedAt: json["publishedAt"] == null ? DateTime.now() : DateTime.parse(json["publishedAt"]),
    content: json["content"] ?? '',
  );
}

class NewsSourceModel {
  NewsSourceModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory NewsSourceModel.fromJson(Map<String, dynamic> json) => NewsSourceModel(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
  );
}
