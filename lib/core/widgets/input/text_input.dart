import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shelve/core/utils/extensions.dart';

class TextInput extends StatefulWidget {
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
  final bool autoDispose;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType type;

  const TextInput({
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
    this.autoDispose = true,
    this.inputFormatters,
    this.type = TextInputType.text,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController controller;
  late FocusNode focus;
  late bool obscure;
  late bool error;
  bool focused = false;

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
      if (mounted) {
        setState(() {
          focused = focus.hasFocus;
        });
      }
    });
    super.initState();
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
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmited,
      textAlignVertical: TextAlignVertical.center,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.type,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: context.text.bodyMedium?.copyWith(
          color: context.theme.disabledColor,
        ),
        labelText: widget.placeholder,
        labelStyle: context.text.bodyMedium?.copyWith(
          color: context.theme.disabledColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 17),
        filled: true,
        fillColor: context.scheme.surfaceVariant,
        prefixIcon: widget.leadingIcon != null
            ? Icon(
                widget.leadingIcon,
                size: 24,
                color: context.theme.disabledColor,
              )
            : null,
        suffixIcon: widget.showVisibilityButton && widget.obscure
            ? Transform.translate(
                offset: const Offset(-5, 0),
                child: IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    size: 21,
                    color: context.theme.disabledColor,
                  ),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                ),
              )
            : null,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: context.scheme.surface,
            width: 1,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: context.scheme.surface,
            width: 1,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: context.scheme.error,
            width: 1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
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
    if (widget.autoDispose) {
      controller.dispose();
      focus.dispose();
    }
    super.dispose();
  }
}
