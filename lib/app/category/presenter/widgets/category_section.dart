import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shelve/app/category/presenter/controller/category_controller.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/widgets/selectors/selector_widget.dart';

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
          return ScrollablePositionedList.separated(
            itemCount: state.data.length,
            scrollDirection: Axis.horizontal,
            itemScrollController: controller.scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                  valueListenable: controller.currentIndex,
                  builder: (context, currentIndex, child) {
                    return SelectorWidget(
                      key: UniqueKey(),
                      icon: Iconcino.byName[state.data[index].icon] ??
                          Iconcino.list,
                      active: currentIndex == index,
                      text: state.data[index].name,
                      onSelect: (category) {
                        controller.changeIndex(index);
                      },
                    );
                  });
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
