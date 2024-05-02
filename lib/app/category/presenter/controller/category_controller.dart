import 'dart:async';

import 'package:flutter/material.dart';
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
  final currentIndex = ValueNotifier(0);
  bool userSwiped = true;
  final pageController = PageController();
  final scrollController = ScrollController();

  Future<void> fetchCategories() async {
    categories.changeToLoadingState();
    final result = await _fetchCategories();

    result.when(
      failure: (error) => categories.changeToErrorState(error),
      success: (data) => categories.changeToSuccessState(data),
    );
  }

  Future<void> saveCategories(List<CategoryEntity> categories) async {
    unawaited(_saveCategories(categories));
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    userSwiped = false;
    pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        )
        .then(
          (value) => userSwiped = true,
        );
  }
}
