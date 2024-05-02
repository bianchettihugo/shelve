import '../../../../core/services/tagging/tagging.service.dart';
import '../../../../core/utils/result.dart';
import '../entities/category_entity.dart';
import '../errors/category_error.dart';
import '../repositories/category_repository.dart';

abstract class SaveCategoriesUsecase {
  Future<Result<CategoryError, bool>> call(List<CategoryEntity> categories);
}

class SaveCategoriesUsecaseImpl implements SaveCategoriesUsecase {
  final CategoryRepository _repository;
  final TaggingService _taggingService;

  SaveCategoriesUsecaseImpl({
    required CategoryRepository repository,
    required TaggingService taggingService,
  })  : _repository = repository,
        _taggingService = taggingService;

  @override
  Future<Result<CategoryError, bool>> call(
      List<CategoryEntity> categories) async {
    final result = await _repository.saveCategories(categories);

    if (result.isSuccess) {
      _taggingService.logEvent('save_categories', {
        'count': categories.length,
      });
    } else {
      _taggingService.logEvent('save_categories_fail', {
        'error': result.error.toString(),
      });
    }

    return result;
  }
}
