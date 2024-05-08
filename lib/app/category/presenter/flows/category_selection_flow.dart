import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shelve/app/category/presenter/controller/category_controller.dart';
import 'package:shelve/app/category/presenter/widgets/category_card.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/extensions.dart';

class CategorySelectionFlow extends StatelessWidget {
  final CategoryController categoryController;

  const CategorySelectionFlow({
    required this.categoryController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: context.scheme.background,
        leadingWidth: 74,
        leading: IconButton(
          icon: const Icon(Iconcino.arrow_back_simple),
          color: context.scheme.onBackground,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: AnimationLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.categoryTitle,
                  style: context.text.headlineSmall,
                  textAlign: TextAlign.start,
                ).animate(),
                const SizedBox(height: 15),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoryController.allCategories.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1.5,
                  ),
                  itemBuilder: (context, index) => CategoryCard(
                    category: categoryController.allCategories[index],
                    onTap: (category) {},
                  ),
                ).animate(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
