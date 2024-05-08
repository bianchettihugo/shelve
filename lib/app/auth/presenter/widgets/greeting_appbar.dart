import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shelve/app/auth/presenter/controller/auth_controller.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/core/values/routes.dart';

import '../../../category/domain/entities/category_entity.dart';

class GreetingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthController authController;
  final Function(List<CategoryEntity>?) onCategoriesChanged;

  const GreetingAppBar({
    required this.authController,
    required this.onCategoriesChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Hello, ${authController.user?.firstName ?? 'user'}',
        style: context.text.bodyMedium,
      ),
      subtitle: Text(
        context.strings.slogan1,
        style: context.text.bodySmall?.copyWith(
          color: context.theme.disabledColor,
        ),
      ),
      minLeadingWidth: 10,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconcino.menu,
            color: context.scheme.onBackground,
            size: 28,
          ),
          const SizedBox(height: 2),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Iconcino.sliders),
            color: context.scheme.onBackground,
            iconSize: 28,
            onPressed: () async {
              final result = await context.pushNamed(Routes.categories);
              if (result != null && result is List<CategoryEntity>) {
                onCategoriesChanged(result);
              }
            },
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: const Icon(Iconcino.search),
            color: context.scheme.onBackground,
            iconSize: 28,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
