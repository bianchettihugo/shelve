import 'package:shelve/app/category/domain/entities/category_entity.dart';
import 'package:shelve/app/category/domain/errors/category_error.dart';
import 'package:shelve/core/utils/result.dart';

abstract class CategoryRepository {
  Future<Result<CategoryError, List<CategoryEntity>>> fetchCategories();

  Future<Result<CategoryError, bool>> saveCategories(
    List<CategoryEntity> categories,
  );
}
