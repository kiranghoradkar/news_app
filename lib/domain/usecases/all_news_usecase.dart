import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/domain/repository/news_repository.dart';

// This s the class for all news usecase
class AllNewsUseCase extends UseCase<List<Article>, GetNewsParams> {
  final NewsRepository newsRepository;

  AllNewsUseCase(this.newsRepository);

  @override
  Future<List<Article>> call(GetNewsParams params) {
    return newsRepository.getAllNews(params);
  }
}
