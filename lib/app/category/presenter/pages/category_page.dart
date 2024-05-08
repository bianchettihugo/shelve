import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shelve/app/category/domain/entities/category_entity.dart';
import 'package:shelve/app/category/presenter/controller/category_controller.dart';
import 'package:shelve/core/services/dependency/dependency_service.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/core/widgets/buttons/button.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryController controller;
  late List<CategoryEntity> categories;

  @override
  void initState() {
    controller = Dependency.get<CategoryController>();
    categories = List.of(controller.categories.value.data);
    super.initState();
  }

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.strings.selectCategories,
                    style: context.text.headlineSmall,
                    textAlign: TextAlign.start,
                  ).animate(),
                  const SizedBox(height: 5),
                  Text(
                    context.strings.selectCategoriesMessage,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.scheme.onSurfaceVariant,
                    ),
                  ).animate(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ReorderableListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                children: <Widget>[
                  for (int index = 0; index < categories.length; index += 1)
                    ListTile(
                      key: Key('$index'),
                      leading: Icon(
                        Iconcino.byName[categories[index].icon] ??
                            Iconcino.list,
                        color: context.scheme.onBackground,
                      ),
                      title: Text(
                        categories[index].name,
                        style: context.text.bodyMedium,
                      ),
                      shape: Border(
                          bottom: BorderSide(
                            color: context.theme.dividerColor,
                            width: 1.0,
                          )),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: Icon(
                          Icons.drag_handle,
                          color: context.theme.dividerColor,
                          size: 30.0,
                        ),
                      ),
                    ),
                ],
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = categories.removeAt(oldIndex);
                    categories.insert(newIndex, item);
                  });
                },
              ).animate(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Button(
                text: context.strings.confirm,
                onPressed: () async {
                  controller.saveCategories(categories);
                  context.pop(categories);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
