import 'package:shelve/core/services/tagging/tagging.service.dart';

import '../../../../core/utils/result.dart';
import '../entities/category_entity.dart';
import '../errors/category_error.dart';
import '../repositories/category_repository.dart';

abstract class FetchCategoriesUsecase {
  Future<Result<CategoryError, List<CategoryEntity>>> call();
}

class FetchCategoriesUsecaseImpl implements FetchCategoriesUsecase {
  final CategoryRepository _repository;
  final TaggingService _taggingService;

  FetchCategoriesUsecaseImpl({
    required CategoryRepository repository,
    required TaggingService taggingService,
  })
      : _repository = repository,
        _taggingService = taggingService;

  @override
  Future<Result<CategoryError, List<CategoryEntity>>> call() async {
    final result = await _repository.fetchCategories();

    if (result.isSuccess) {
      _taggingService.logEvent('fetch_categories', {});
    } else {
      _taggingService.logEvent('fetch_categories_fail', {
        'error': result.error.toString(),
      });
    }

    return result;
  }
}
