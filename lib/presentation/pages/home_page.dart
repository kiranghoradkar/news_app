import 'package:flutter/material.dart';
import 'package:news_app/presentation/pages/categories_page.dart';
import 'package:news_app/presentation/pages/my_feed_page.dart';
import 'package:news_app/presentation/viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';

/// This is the home page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = context.read<NewsViewModel>();
    return Scaffold(
        body: PageView(
      controller: pageController,
      children: [
        CategoryPage(
          onNext: () {
            // Navigate to next page of PageView
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate);
          },
          onSelectNews: (index) {
            newsViewModel.selectNews(index);
            pageController.animateToPage(1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate);
          },
        ),
        MyFeedPage(
          onPrevious: () {
            // Navigate to previous page of PageView
            pageController.animateToPage(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate);
          },
        ),
      ],
    ));
  }
}
