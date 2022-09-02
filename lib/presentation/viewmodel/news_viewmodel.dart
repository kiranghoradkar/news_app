import 'package:flutter/material.dart';
import 'package:news_app/core/error/failures_error.dart';
import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/domain/usecases/all_bookmarks.dart';
import 'package:news_app/domain/usecases/all_news_usecase.dart';
import 'package:news_app/domain/usecases/save_bookmark.dart';
import 'package:news_app/domain/usecases/topheadline_usecase.dart';

class NewsViewModel extends ChangeNotifier{
  // All UseCases
  final AllNewsUseCase allNewsUseCase;
  final SaveBookmarkUseCase saveBookmarkUseCase;
  final AllBookmarksUseCase allBookmarksUseCase;
  final TopHeadLinesUseCase topHeadLinesUseCase;
  int selectedCategory = 0; // Here 0 is index of selected category
  int selectedNews = 0; // Here 0 is index of selected news/article

  List<CategoryModel> categoryList = [
    CategoryModel('All'),
    CategoryModel('Top Headline'),
    CategoryModel('Bookmarks')
  ];

  NewsViewModel(
      {required this.saveBookmarkUseCase,
      required this.allBookmarksUseCase,
      required this.topHeadLinesUseCase,
      required this.allNewsUseCase}) {
    selectCategory(0);
  }

  // This method is for to get all news
  void getEveryNews(GetNewsParams params) async {
    // AllNews allNews = await allNewsUseCase(params); // we can write below line like this
    try {
      List<Article> articles = await allNewsUseCase.call(params);
      categoryList[0].articles = articles;
    } on ServerFailure catch (error) {
      debugPrint(error.toString());
    } on NoInternet catch (error) {
      debugPrint(error.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
    notifyListeners();
  }

  // This method is for to get top new headlines
  void getTopHeadLines(GetNewsParams params) async {
    try {
      List<Article> articles = await topHeadLinesUseCase.call(params);
      categoryList[1].articles = articles;
    } on ServerFailure catch (error) {
      debugPrint(error.toString());
    } on NoInternet catch (error) {
      debugPrint(error.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
    notifyListeners();
  }

  // This method is for to get saved bookmark from database
  void getBookmarks() async {
    // List<Article> articles = await allBookmarksUseCase.call(NoParams());
    // categoryList[2].articles = articles;
    try {
      List<Article> articles = await allBookmarksUseCase.call(NoParams());
      categoryList[2].articles = articles;
    } on ServerFailure catch (error) {
      debugPrint(error.toString());
    } on NoInternet catch (error) {
      debugPrint(error.toString());
    } catch (error) {
      debugPrint(error.toString());
    }

    notifyListeners();
  }

  // This method is for to save bookmark in local database
  void saveBookmark(Article article) async {
    Article articleSaved = await saveBookmarkUseCase.call(article);
    categoryList[2].articles?.add(articleSaved);
    notifyListeners();
  }

  // When we tap on all , top category , book mark on category page we are calling there api depending on index
  void selectCategory(int index) {
    selectedCategory = index;
    switch (index) {
      case 0:
        // get All news
        getEveryNews(GetNewsParams(q: "bitcoin", category: 'all'));
        break;
      case 1:
        // get Top headlines
        getTopHeadLines(GetNewsParams(country: "us", category: 'top'));
        break;
      case 2:
        // Get Bookmarks
        getBookmarks();
        break;
    }
    notifyListeners();
  }

  void selectNews(int index) {
    selectedNews = index;
    notifyListeners();
  }
}
