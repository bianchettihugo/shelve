import 'package:shelve/app/category/data/datasources/category_datasource.dart';
import 'package:shelve/app/category/data/datasources/category_datasource_impl.dart';
import 'package:shelve/app/category/domain/usecases/fetch_categories_usecase.dart';
import 'package:shelve/app/category/domain/usecases/save_categories_usecase.dart';
import 'package:shelve/app/category/presenter/controller/category_controller.dart';
import 'package:shelve/app/category/presenter/widgets/category_section.dart';
import 'package:shelve/core/services/dependency/dependency_service.dart';
import 'package:shelve/core/services/storage/local_storage.service.dart';
import 'package:shelve/core/values/keys.dart';
import 'package:shelve/core/widgets/flow/flow.dart';

import '../../core/services/tagging/tagging.service.dart';
import 'data/repositories/category_repository_impl.dart';
import 'domain/repositories/category_repository.dart';

class CategoryModule {
  static void init() {
    Dependency.register<CategoryDatasource>(CategoryDatasourceImpl(
      storageService: Dependency.get<LocalStorageService>(),
    ));

    Dependency.register<CategoryRepository>(CategoryRepositoryImpl(
      categoryDatasource: Dependency.get<CategoryDatasource>(),
    ));

    Dependency.register<FetchCategoriesUsecase>(FetchCategoriesUsecaseImpl(
      repository: Dependency.get<CategoryRepository>(),
      taggingService: Dependency.get<TaggingService>(),
    ));

    Dependency.register<SaveCategoriesUsecase>(SaveCategoriesUsecaseImpl(
      repository: Dependency.get<CategoryRepository>(),
      taggingService: Dependency.get<TaggingService>(),
    ));

    Dependency.register<CategoryController>(CategoryController(
      fetchCategoriesUsecase: Dependency.get<FetchCategoriesUsecase>(),
      saveCategoriesUsecase: Dependency.get<SaveCategoriesUsecase>(),
    ));

    Dependency.registerFactory(
      () => FeatureFlow(
        builder: (context, params) => CategorySection(
          controller: Dependency.get<CategoryController>(),
        ),
      ),
      Keys.categoryList,
    );
  }
}
