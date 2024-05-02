import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

class RadioOption<T> extends StatefulWidget {
  final String value;
  final List<String> options;
  final Function(String) onSelect;
  final String title;
  final String? description;

  const RadioOption({
    required this.value,
    required this.options,
    required this.onSelect,
    required this.title,
    this.description,
    super.key,
  });

  @override
  State<RadioOption<T>> createState() => _RadioOptionState<T>();
}

class _RadioOptionState<T> extends State<RadioOption<T>> {
  late String? _selected;

  @override
  void initState() {
    _selected = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(6),
      color: context.scheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.start,
              style: context.text.bodyMedium,
            ),
            if (widget.description != null) ...[
              const SizedBox(height: 5),
              Text(
                widget.description!,
                style: context.text.bodySmall?.copyWith(
                  color: context.theme.disabledColor,
                ),
              ),
            ],
            const SizedBox(height: 10),
            ...List.generate(widget.options.length, (index) {
              final option = widget.options[index];
              return RadioListTile<String>(
                title: Text(option, style: context.text.bodyMedium),
                value: option,
                groupValue: _selected,
                activeColor: context.scheme.primary,
                onChanged: (value) {
                  widget.onSelect(value ?? '');
                  setState(() {
                    _selected = value;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
