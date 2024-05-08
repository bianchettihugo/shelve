import 'package:flutter/material.dart';
import 'package:shelve/app/category/domain/entities/category_entity.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/extensions.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final Function(CategoryEntity) onTap;
  final double elevation;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Iconcino.byName[category.icon] ?? Iconcino.list,
        color: context.scheme.onBackground,
      ),
      title: Text(
        category.name,
        style: context.text.bodyMedium,
      ),
      trailing: Icon(
        Iconcino.arrow_forward_simple,
        color: context.theme.disabledColor,
        size: 16,
      ),
      onTap: () => onTap(category),
    );
  }
}
