import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

import '../../theme/iconcino_icons.dart';
import '../buttons/link_button.dart';

class FailureWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTryAgain;

  const FailureWidget({
    required this.title,
    required this.description,
    required this.onTryAgain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.scheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                Iconcino.error,
                size: 52,
                color: context.scheme.error,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: context.text.bodyLarge,
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: context.text.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            LinkButton(
              text: context.strings.tryAgain,
              onPressed: onTryAgain,
            ),
          ],
        ),
      ),
    );
  }
}
