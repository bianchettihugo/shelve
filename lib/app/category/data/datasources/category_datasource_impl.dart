import 'package:shelve/app/category/data/datasources/category_datasource.dart';
import 'package:shelve/app/category/data/models/category_model.dart';
import 'package:shelve/core/services/storage/local_storage.service.dart';
import 'package:shelve/core/values/keys.dart';

class CategoryDatasourceImpl extends CategoryDatasource {
  final LocalStorageService _storageService;

  CategoryDatasourceImpl({required LocalStorageService storageService})
      : _storageService = storageService;

  final _categories = {
    'All': CategoryModel(
      name: 'All',
      icon: 'format_list_bulleted',
      active: true,
      order: 0,
    ),
    'Notes': CategoryModel(
      name: 'Notes',
      icon: 'note_02',
      active: false,
      order: 1,
    ),
    'Cards': CategoryModel(
      name: 'Cards',
      icon: 'credit_card',
      active: false,
      order: 2,
    ),
    'Passwords': CategoryModel(
      name: 'Passwords',
      icon: 'lock',
      active: false,
      order: 3,
    ),
    'Adresses': CategoryModel(
      name: 'Adresses',
      icon: 'pin_drop',
      active: false,
      order: 4,
    ),
    'Tickets': CategoryModel(
      name: 'Tickets',
      icon: 'ticket',
      active: false,
      order: 5,
    ),
    'Recipes': CategoryModel(
      name: 'Recipes',
      icon: 'bowl',
      active: false,
      order: 6,
    ),
    'QR & bar codes': CategoryModel(
      name: 'QR & bar codes',
      icon: 'scan',
      active: false,
      order: 7,
    ),
  };

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final categories = _storageService.getListString(Keys.categoryList);
    if (categories == null || categories.isEmpty) {
      await _storageService.setListString(
        Keys.categoryList,
        _categories.keys.toList(),
      );
      return _categories.values.toList();
    } else {
      final categoryList = <CategoryModel>[];
      for (var i = 0; i < categories.length; i++) {
        categoryList.add(_categories[categories[i]]!.copyWith(
          order: i,
        ));
      }
      return categoryList;
    }
  }

  @override
  Future<bool> saveCategories(List<CategoryModel> categories) async {
    await _storageService.setListString(
      Keys.categoryList,
      categories.map((e) => e.name).toList(),
    );
    return true;
  }
}
