import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
/// This is class for news repository
abstract class NewsRepository {
  // This is the method for to get all news
  Future<List<Article>> getAllNews(GetNewsParams params);

  // This is the method for to get top headlines
  Future<List<Article>> getTopHeadLines(GetNewsParams params);

  // This method is for to save all news
  void saveAllNews(List<Article> articles, String category);

  // This method is for to get all news by category
  Future<List<Article>> getAllNewsByCategory(String category);

  // This method is for to get all bookmarks
  Future<List<Article>> getAllBookmarks();

  // This method is for to save bookmark
  Future<Article> saveBookmark(Article article);
}
