import 'package:news_app/core/usecase_base/usecase_base.dart';
import 'package:news_app/data/models/all_news_models.dart';
import 'package:news_app/domain/entity/all_news_entities.dart';
import 'package:news_app/domain/repository/news_repository.dart';

// This is the class for top headline usecase
class TopHeadLinesUseCase extends UseCase<List<Article>, GetNewsParams> {
  final NewsRepository newsRepository;

  TopHeadLinesUseCase(this.newsRepository);

  @override
  Future<List<Article>> call(GetNewsParams params) {
    return newsRepository.getTopHeadLines(params);
  }
}
