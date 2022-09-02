import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/presentation/viewmodel/news_viewmodel.dart';
import 'package:provider/provider.dart';

/// This is the class for my feed
class MyFeedPage extends StatefulWidget {
  final Function onPrevious;

  const MyFeedPage({Key? key, required this.onPrevious}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Feed',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            widget.onPrevious();
          },
        ),
      ),
      body: Consumer(builder:
          (BuildContext context, NewsViewModel newsViewModel, Widget? child) {
        return PageView.builder(
            controller: PageController(initialPage: newsViewModel.selectedNews),
            scrollDirection: Axis.vertical,
            itemCount: newsViewModel
                    .categoryList[newsViewModel.selectedCategory]
                    .articles
                    ?.length ??
                0,
            itemBuilder: (context, index) {
              Article article = newsViewModel
                  .categoryList[newsViewModel.selectedCategory]
                  .articles![index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const Center(
                      child: Icon(Icons.image),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: Text(
                      article.title ?? '',
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                    child: Text(
                      article.description ?? '',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
                    child: Text(
                      article.content ?? '',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(article.author ?? ''),
                      IconButton(
                        tooltip: 'Bookmark',
                          onPressed: () {
                            newsViewModel.saveBookmark(article);
                            Fluttertoast.showToast(
                                msg: "News added successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                          icon: const Icon(
                            Icons.bookmark,
                            color: Colors.pink,
                          )),
                    ],
                  ),
                ],
              );
            });
      }),
    );
  }
}
