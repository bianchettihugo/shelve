import 'package:shelve/app/category/data/models/category_model.dart';

abstract class CategoryDatasource {
  Future<List<CategoryModel>> fetchCategories();

  Future<bool> saveCategories(List<CategoryModel> categories);
}