import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/data/datasource/database_helper.dart';
import 'package:news_app/data/repository/repository_implementation.dart';
import 'package:news_app/domain/usecases/all_bookmarks.dart';
import 'package:news_app/domain/usecases/all_news_usecase.dart';
import 'package:news_app/domain/usecases/save_bookmark.dart';
import 'package:news_app/domain/usecases/topheadline_usecase.dart';
import 'package:news_app/presentation/pages/home_page.dart';
import 'package:news_app/presentation/viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// This widget is the root of your application.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (BuildContext context) {
            var newsRepository = NewsRepositoryImplementation(
                NetworkInfoImpl(connectivity: Connectivity()),
                Dio(),
                DataBaseHelper.instance);

            return NewsViewModel(
                saveBookmarkUseCase: SaveBookmarkUseCase(newsRepository),
                allBookmarksUseCase: AllBookmarksUseCase(newsRepository),
                allNewsUseCase: AllNewsUseCase(newsRepository),
                topHeadLinesUseCase: TopHeadLinesUseCase(newsRepository));
          },
          child: const HomePage()),
    );
  }
}
