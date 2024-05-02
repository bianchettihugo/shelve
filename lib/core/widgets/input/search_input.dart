import 'dart:async';

import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:shelve/core/theme/iconcino_icons.dart';
import 'package:shelve/core/utils/extensions.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final String hint;
  final String label;
  final String? placeholder;
  final bool obscure;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? Function(String?)? validator;
  final String Function(String)? formatter;
  final Map<bool, String> Function(String?)? validate;
  final String? id;
  final String? initialValue;
  final void Function(String)? onChanged;
  final bool autoFocus;
  final bool showVisibilityButton;
  final bool error;
  final TextInputAction action;
  final void Function(String)? onSubmited;
  final Map<String, dynamic>? data;

  const SearchInput({
    super.key,
    this.controller,
    this.focus,
    this.hint = '',
    this.label = '',
    this.placeholder,
    this.leadingIcon,
    this.trailingIcon,
    this.validator,
    this.validate,
    this.formatter,
    this.id,
    this.initialValue,
    this.onChanged,
    this.obscure = false,
    this.autoFocus = true,
    this.showVisibilityButton = true,
    this.action = TextInputAction.next,
    this.error = false,
    this.onSubmited,
    this.data,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late TextEditingController controller;
  late FocusNode focus;
  late bool obscure;
  late bool error;
  bool focused = false;
  bool hasText = false;

  Timer? _debounce;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    error = widget.error;
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    } else if (widget.data != null) {
      controller.text = widget.data![widget.id] ?? '';
    }
    focus = widget.focus ?? FocusNode();
    obscure = widget.obscure;
    focus.addListener(() {
      setState(() {
        focused = focus.hasFocus;
      });
    });
    super.initState();
  }

  void _onChanged(String text) {
    if (text.isNotEmpty && !hasText) {
      setState(() {
        hasText = true;
      });
    } else if (text.isEmpty && hasText) {
      setState(() {
        hasText = false;
      });
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      widget.onChanged?.call(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataFormTextField(
      id: widget.id ?? '',
      obscureText: obscure,
      controller: controller,
      focusNode: focus,
      validator: widget.validator,
      validate: widget.validate,
      textInputAction: widget.action,
      onChanged: _onChanged,
      onSubmitted: widget.onSubmited,
      textAlignVertical: TextAlignVertical.center,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: context.text.bodyMedium?.copyWith(
          color: context.theme.disabledColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
        filled: true,
        fillColor: context.scheme.surfaceVariant,
        prefixIcon: widget.leadingIcon != null
            ? Icon(
                widget.leadingIcon,
                size: 24,
                color: focus.hasFocus
                    ? context.theme.primaryColor
                    : context.theme.disabledColor,
              )
            : null,
        suffixIcon: hasText
            ? Transform.translate(
                offset: const Offset(-5, 0),
                child: IconButton(
                  icon: Icon(
                    Iconcino.close,
                    size: 21,
                    color: context.theme.disabledColor,
                  ),
                  onPressed: () {
                    controller.text = '';
                    setState(() {
                      hasText = false;
                    });
                  },
                ),
              )
            : null,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: context.scheme.surface,
            width: 1,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: context.scheme.surface,
            width: 1,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: context.scheme.error,
            width: 1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: context.scheme.surface,
            width: 1,
          ),
        ),
      ),
      style: context.text.bodyMedium?.copyWith(
        color: context.theme.colorScheme.onSurface,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
