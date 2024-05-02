import 'package:shelve/app/category/data/datasources/category_datasource.dart';
import 'package:shelve/app/category/data/errors/category_error_impl.dart';
import 'package:shelve/app/category/domain/entities/category_entity.dart';
import 'package:shelve/app/category/domain/errors/category_error.dart';
import 'package:shelve/app/category/domain/repositories/category_repository.dart';
import 'package:shelve/core/utils/result.dart';

import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource _categoryDatasource;

  CategoryRepositoryImpl({
    required CategoryDatasource categoryDatasource,
  }) : _categoryDatasource = categoryDatasource;

  @override
  Future<Result<CategoryError, List<CategoryEntity>>> fetchCategories() async {
    try {
      final result = await _categoryDatasource.fetchCategories();
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(CategoryErrorImpl.defaultError());
    }
  }

  @override
  Future<Result<CategoryError, bool>> saveCategories(
    List<CategoryEntity> categories,
  ) async {
    try {
      final result = await _categoryDatasource.saveCategories(
        categories.map((e) => CategoryModel.fromEntity(e)).toList(),
      );
      return Result.success(result);
    } catch (e) {
      return Result.failure(CategoryErrorImpl.defaultError());
    }
  }
}
