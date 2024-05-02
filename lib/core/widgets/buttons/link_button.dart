import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onPressed;
  final double? width;
  final double? iconWidth;
  final Alignment? alignment;

  const LinkButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.alignment,
    this.width,
    this.iconWidth,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-8, 0),
      child: TextButton.icon(
        onPressed: onPressed,
        style: ButtonStyle(
          alignment: alignment,
          minimumSize: MaterialStateProperty.all<Size>(
            Size(width ?? double.infinity, 48),
          ),
        ),
        icon: icon != null
            ? Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: iconWidth ?? 28,
              )
            : const SizedBox(),
        label: Transform.translate(
          offset: const Offset(-5, 0),
          child: Text(
            text,
            style: context.text.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
