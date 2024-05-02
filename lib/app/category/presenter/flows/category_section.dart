import 'package:flutter/material.dart';
import 'package:shelve/app/category/presenter/controller/category_controller.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/widgets/selectors/selector_widget.dart';

import '../../domain/entities/category_entity.dart';

class CategorySection extends StatelessWidget {
  final CategoryController controller;

  const CategorySection({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.categories,
      builder: (context, state, child) {
        if (state.isSuccess) {
          return ValueListenableBuilder(
            valueListenable: controller.currentIndex,
            builder: (context, currentIndex, child) {
              return _CategoryList(
                key: UniqueKey(),
                data: state.data,
                controller: controller,
                currentIndex: currentIndex,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<CategoryEntity> data;
  final CategoryController controller;
  final int currentIndex;

  const _CategoryList({
    required this.data,
    required this.controller,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('k_categ'),
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      controller: controller.scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      separatorBuilder: (context, index) {
        return const SizedBox(width: 10);
      },
      itemBuilder: (context, index) {
        return SelectorWidget(
          icon: Iconcino.byName[data[index].icon] ?? Iconcino.list,
          active: currentIndex == index,
          text: data[index].name,
          onSelect: (category) {
            controller.changeIndex(index);
          },
        );
      },
    );
  }
}
