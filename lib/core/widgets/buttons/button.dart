import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class Button extends StatelessWidget {
  final String text;
  final Widget? icon;
  final void Function() onPressed;
  final TextDirection direction;
  final bool secondary;
  final bool enabled;

  const Button({
    required this.text,
    required this.onPressed,
    this.direction = TextDirection.rtl,
    this.icon,
    this.secondary = false,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: direction,
      child: ElevatedButton.icon(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          visualDensity: VisualDensity.comfortable,
          elevation: MaterialStateProperty.all(secondary ? 0 : null),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: !enabled
                  ? BorderSide.none
                  : BorderSide(color: context.theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            enabled
                ? secondary
                    ? context.scheme.background
                    : context.theme.primaryColor
                : context.theme.dividerColor,
          ),
          overlayColor: secondary
              ? MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed)
                        ? context.theme.primaryColorLight.withOpacity(0.2)
                        : null;
                  },
                )
              : null,
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(double.infinity, 60),
          ),
        ),
        icon: icon != null
            ? (icon is Icon ? Icon((icon as Icon).icon, size: 24) : icon!)
            : const SizedBox.shrink(),
        label: Text(
          text,
          style: context.text.bodyMedium?.copyWith(
            color: enabled
                ? secondary
                    ? context.theme.primaryColor
                    : context.theme.colorScheme.onPrimary
                : context.scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
