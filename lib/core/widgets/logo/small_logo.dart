import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

import '../../values/files.dart';

class SmallLogo extends StatelessWidget {
  const SmallLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(Files.logo, width: 21),
          const SizedBox(width: 3),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              'Shelve',
              style: context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.theme.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
