import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shelve/app/category/domain/usecases/fetch_categories_usecase.dart';
import 'package:shelve/app/category/domain/usecases/save_categories_usecase.dart';

import '../../../../core/utils/state.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/errors/category_error.dart';

class CategoryController {
  final FetchCategoriesUsecase _fetchCategories;
  final SaveCategoriesUsecase _saveCategories;

  CategoryController({
    required FetchCategoriesUsecase fetchCategoriesUsecase,
    required SaveCategoriesUsecase saveCategoriesUsecase,
  })  : _fetchCategories = fetchCategoriesUsecase,
        _saveCategories = saveCategoriesUsecase;

  final categories = ReactiveState<CategoryError, List<CategoryEntity>>();
  final allCategories = <CategoryEntity>[];
  final currentIndex = ValueNotifier(0);
  bool userSwiped = true;
  final pageController = PageController();
  final scrollController = ItemScrollController();

  Future<void> fetchCategories() async {
    categories.changeToLoadingState();
    final result = await _fetchCategories();

    result.when(
      failure: (error) => categories.changeToErrorState(error),
      success: (data) {
        allCategories.addAll(data.where((element) => element.name != 'All'));
        categories.changeToSuccessState(data);
      },
    );
  }

  Future<void> saveCategories(List<CategoryEntity> categories) async {
    unawaited(_saveCategories(categories));
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    userSwiped = false;
    pageController.jumpToPage(
      index,
    );
    userSwiped = true;
  }
}
