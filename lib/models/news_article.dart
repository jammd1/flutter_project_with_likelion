class NewsArticle {
  String title;
  String description;
  String url;
  String? imageUrl;
  String publishedAt;
  String? source;

  NewsArticle({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.url,
    required this.publishedAt,
    this.source,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      imageUrl: json['urlToImage'],
      source: json['source']?['name'],
    );
  }
}
