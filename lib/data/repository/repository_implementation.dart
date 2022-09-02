import 'package:dio/dio.dart';
import 'package:news_app/core/conatants/common_constant.dart';
import 'package:news_app/core/error/failures_error.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/data/datasource/database_helper.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/domain/repository/news_repository.dart';

/// NewsRepositoryImplementation is class for calling api and getting data from local database
class NewsRepositoryImplementation implements NewsRepository {
  final NetworkInfo networkInfo;
  final Dio dio;
  final DataBaseHelper dataBaseHelper;

  NewsRepositoryImplementation(this.networkInfo, this.dio, this.dataBaseHelper);

  @override
  Future<List<ArticleModel>> getAllNews(GetNewsParams params) async {
    if (await networkInfo.isConnected) {
      final response = await dio.get(CommonConstants.getAllNews,
          queryParameters: {'q': params.q, 'apiKey': CommonConstants.apiKey});

      if (response.statusCode == 200) {
        var news = AllNewsModel.fromJson(response.data);
        if (news.articles != null) {
          saveAllNews(news.articles!, params.category);
        }
        return news.articles ?? [];
      } else {
        throw ServerFailure(message: 'Server Error');
      }
    } else {
      // throw NoInternet(message: 'No Internet Connection');
      var articles = await getAllNewsByCategory(params.category);
      return articles as List<ArticleModel>;
    }
  }

  @override
  Future<List<ArticleModel>> getTopHeadLines(GetNewsParams params) async {
    if (await networkInfo.isConnected) {
      final response = await dio.get(CommonConstants.getTopHeadLine,
          queryParameters: {
            'country': params.country,
            'apiKey': CommonConstants.apiKey
          });

      if (response.statusCode == 200) {
        var news = AllNewsModel.fromJson(response.data);
        if (news.articles != null) {
          saveAllNews(news.articles!, params.category);
        }
        return news.articles ?? [];
      } else {
        throw ServerFailure(message: 'Server Error');
      }
    } else {
      // throw NoInternet(message: 'No Internet Connection');
      var articles = await getAllNewsByCategory(params.category);
      return articles as List<ArticleModel>;
    }
  }

  /// This method is for to save all news in database
  @override
  void saveAllNews(List<Article> articles, category) async {
    await dataBaseHelper.createAll(articles, category);
  }

  /// This method is for to to get all news by category
  @override
  Future<List<Article>> getAllNewsByCategory(String category) async {
    return await dataBaseHelper.getAllArticlesByCategory(category);
  }

  /// This method is for to get all bookmark form local database
  @override
  Future<List<Article>> getAllBookmarks() async {
    return await dataBaseHelper.getAllBookmarks();
  }

  /// This method is for to save bookmarks in local database
  @override
  Future<Article> saveBookmark(Article article) async {
    return await dataBaseHelper.createBookmark(article);
  }
}
