import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/presentation/viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';

/// This class is for category
class CategoryPage extends StatefulWidget {
  final Function onNext;
  final Function onSelectNews;

  const CategoryPage(
      {Key? key, required this.onNext, required this.onSelectNews})
      : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () {
              widget.onNext();
            },
          ),
        ],
      ),
      body: Consumer<NewsViewModel>(
        builder: (BuildContext context, newsViewModel, Widget? child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsViewModel.categoryList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 6, 50, 2),
                          child: TextButton(
                            onPressed: () {
                              newsViewModel.selectCategory(index);
                            },
                            child: Text(newsViewModel.categoryList[index].name),
                          ),
                        );
                      }),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsViewModel
                            .categoryList[newsViewModel.selectedCategory]
                            .articles
                            ?.length ??
                        0,
                    primary: false,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          widget.onSelectNews(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(newsViewModel
                                          .categoryList[
                                              newsViewModel.selectedCategory]
                                          .articles?[index]
                                          .description ??
                                      '')),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: CachedNetworkImage(
                                  height: 100,
                                  width: 120,
                                  imageUrl: newsViewModel
                                          .categoryList[
                                              newsViewModel.selectedCategory]
                                          .articles?[index]
                                          .urlToImage ??
                                      "",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const Center(
                                    child: Icon(Icons.image),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
