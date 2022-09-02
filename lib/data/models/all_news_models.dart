import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';

// Article class a news model class
class ArticleModel extends Article implements Params {
  ArticleModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.category})
      : super(
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content,
            category: category);

  ArticleModel.fromJson(dynamic json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
    category = json['category'];
  }

  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    // map['url'] = url;
    map['urlToImage'] = urlToImage;
    // map['publishedAt'] = publishedAt;
    map['content'] = content;
    map['category'] = category;
    return map;
  }
}

class AllNewsModel {
  AllNewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  AllNewsModel.fromJson(dynamic json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(ArticleModel.fromJson(v));
      });
    }
  }

  String? status;
  int? totalResults;
  List<ArticleModel>? articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['totalResults'] = totalResults;
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoryModel {
  String name;
  List<Article>? articles;

  CategoryModel(this.name);
}
