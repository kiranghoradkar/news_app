import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/domain/repository/news_repository.dart';

// Use case for all book marks
class AllBookmarksUseCase extends UseCase<List<Article>, NoParams> {
  final NewsRepository newsRepository;

  AllBookmarksUseCase(this.newsRepository);

  @override
  Future<List<Article>> call(NoParams params) {
    return newsRepository.getAllBookmarks();
  }
}
