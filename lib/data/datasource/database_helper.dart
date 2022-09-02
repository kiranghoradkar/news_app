import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// This class is for to perform database related operation like insert update and delete
class DataBaseHelper {
  static const dbName = 'myDataBase.db';
  static const dbVersion = 1;

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? dataBase;

  // Method to initialize database
  Future<Database> get database async {
    if (dataBase != null) return dataBase!;
    dataBase = await initializeDataBase();
    return dataBase!;
  }

  // method to open database
  initializeDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: createDB);
  }

  // method to create table in database
  FutureOr<void> createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    await db.execute(
        '''CREATE TABLE ${NewsTableFields.tableName}(${NewsTableFields.id} $idType,
    ${NewsTableFields.description} $textType,
    ${NewsTableFields.category} $textType,
    ${NewsTableFields.urlToImage} $textType,
    ${NewsTableFields.content} $textType,
    ${NewsTableFields.title} $textType,
    ${NewsTableFields.author} $textType)''');

    await db.execute(
        '''CREATE TABLE ${BookmarkTableFields.tableName}(${BookmarkTableFields.id} $idType,
    ${BookmarkTableFields.description} $textType,
    ${BookmarkTableFields.category} $textType,
    ${BookmarkTableFields.urlToImage} $textType,
    ${NewsTableFields.content} $textType,
    ${NewsTableFields.title} $textType,
    ${NewsTableFields.author} $textType)''');
  }

  // method to save bookmark in local database
  Future<ArticleModel> createBookmark(Article article) async {
    ArticleModel articleModel = article as ArticleModel;
    final db = await instance.database;
    var result =
        await db.insert(BookmarkTableFields.tableName, articleModel.toJson());
    debugPrint(result.toString());
    return article;
  }

  // method to save all article in local database
  Future createAll(List<Article> articles, category) async {
    final db = await instance.database;
    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(NewsTableFields.tableName,
          where: '${NewsTableFields.category} = ?', whereArgs: [category]);
      for (Article element in articles) {
        ArticleModel articleModel = element as ArticleModel;
        element.category = category;
        batch.insert(NewsTableFields.tableName, articleModel.toJson());
      }
      await batch.commit(noResult: true);
    });

    debugPrint('Save articles');
  }

  // method to get list of Articles from local database
  Future<List<Article>> getAllArticlesByCategory(String category) async {
    final db = await instance.database;
    var result = await db.query(NewsTableFields.tableName,
        where: '${NewsTableFields.category} = ?', whereArgs: [category]);
    List<ArticleModel> list =
        result.map((json) => ArticleModel.fromJson(json)).toList();
    return list;
  }

  // method to get list of bookmarks from local database
  Future<List<ArticleModel>> getAllBookmarks() async {
    final db = await instance.database;
    final result = await db.query(BookmarkTableFields.tableName);
    List<ArticleModel> list =
        result.map((json) => ArticleModel.fromJson(json)).toList();
    return list;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

abstract class NewsTableFields {
  static const String tableName = 'News';
  static const String id = 'id';
  static const String description = 'description';
  static const String urlToImage = 'urlToImage';
  static const String category = 'category';
  static const String content = 'content';
  static const String author = 'author';
  static const String title = 'title';
}

abstract class BookmarkTableFields {
  static const String tableName = 'Bookmark';
  static const String id = 'id';
  static const String description = 'description';
  static const String urlToImage = 'urlToImage';
  static const String category = 'category';
  static const String content = 'content';
  static const String author = 'author';
  static const String title = 'title';
// When you add new fields here then please add fields in Articles.toJson() also
}
