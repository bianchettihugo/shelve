import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class SelectorWidget extends StatefulWidget {
  final bool active;
  final IconData icon;
  final String text;
  final void Function(String)? onSelect;
  final void Function(String)? onDeselect;

  const SelectorWidget({
    super.key,
    this.active = false,
    required this.icon,
    required this.text,
    this.onSelect,
    this.onDeselect,
  });

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  late bool active;

  @override
  void initState() {
    active = widget.active;
    super.initState();
  }

  void _changeState() {
    if (widget.onSelect != null && !active) {
      widget.onSelect!(widget.text);
    }

    if (widget.onDeselect != null && active) {
      widget.onDeselect!(widget.text);
    }

    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      onPressed: _changeState,
      elevation: 0,
      fillColor: active
          ? context.scheme.primaryContainer
          : context.scheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: active ? context.scheme.primary : context.scheme.onSurface,
            size: 20,
          ),
          const SizedBox(width: 5),
          Text(
            widget.text,
            style: context.text.bodyMedium?.copyWith(
              color: active ? context.scheme.primary : context.scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
