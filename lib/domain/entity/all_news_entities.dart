import 'package:news_app/core/usecase_base/usecase_base.dart';

// Article class a news model class
class Article implements Params {
  Article(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.category});

  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? category;
}

class AllNews {
  AllNews({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;
}
