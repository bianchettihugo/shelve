import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? fillColor;

  const ButtonIcon({
    required this.icon,
    required this.onPressed,
    this.color,
    this.fillColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      fillColor: fillColor ?? context.theme.primaryColor,
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        icon,
        color: color ?? context.scheme.onPrimary,
        size: 26,
      ),
    );
  }
}
