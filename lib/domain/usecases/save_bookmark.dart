import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/domain/repository/news_repository.dart';

// This class is for save bookmark usecase
class SaveBookmarkUseCase extends UseCase<Article, Article> {
  final NewsRepository newsRepository;

  SaveBookmarkUseCase(this.newsRepository);

  @override
  Future<Article> call(Article params) {
    return newsRepository.saveBookmark(params);
  }
}
