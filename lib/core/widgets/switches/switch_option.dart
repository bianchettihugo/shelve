// ignore: implementation_imports
import 'package:dataform/src/form/dataform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';

/// Specifies the position of the switch in the [DataFormSwitch] widget
enum SwitchPosition {
  /// The switch is on the left side of the content
  left,

  /// The switch is on the right side of the content
  right
}

/// A widget that displays a switch with a text and a description
///
/// Can be used inside a [DataForm] widget and have an id to save the value
/// on a data map
class SwitchOption extends StatefulWidget {
  /// The text to display
  final String text;

  /// The optional description to display below the text
  final String? description;

  /// The style of the text
  final TextStyle? style;

  /// The style of the description
  final TextStyle? descriptionStyle;

  /// Whether to use the Material 3 design
  final bool useMaterial3;

  /// Whether the switch is active or not
  final bool active;

  /// The function to call when the switch is changed
  // ignore: avoid_positional_boolean_parameters
  final Function(bool)? onChanged;

  /// The color of the border
  final Color? borderColor;

  /// The id to save the value on a data map
  final String? id;

  /// Whether to use a background color
  final bool background;

  /// A function to call before changing the value. If the function returns
  /// true, the value will be changed, otherwise it will not
  final Future<bool> Function()? conditional;

  /// The color scheme to use on the switch
  final ColorScheme? colorScheme;

  /// Whether to unfocus the scope when the value is changed
  final bool unfocusOnChange;

  /// The decoration of the widget
  final BoxDecoration? decoration;

  /// The icon to display on the thumb
  final Icon? thumbIcon;

  /// The color of the track
  final Color? trackColor;

  /// The color of the thumb
  final Color? thumbColor;

  /// The position of the switch
  final SwitchPosition switchPosition;

  /// Creates a new switch option
  const SwitchOption({
    required this.text,
    this.description,
    this.style,
    this.descriptionStyle,
    this.active = false,
    this.onChanged,
    this.borderColor,
    this.id,
    this.background = false,
    this.conditional,
    this.useMaterial3 = false,
    this.unfocusOnChange = true,
    this.colorScheme,
    this.decoration,
    this.thumbIcon,
    this.trackColor,
    this.thumbColor,
    this.switchPosition = SwitchPosition.right,
    super.key,
  });

  @override
  State<SwitchOption> createState() => _SwitchOptionState();
}

class _SwitchOptionState extends State<SwitchOption> {
  late bool active;

  @override
  void initState() {
    active = widget.active;
    super.initState();
  }

  Future<void> _onChange([bool? value]) async {
    if (widget.unfocusOnChange) FocusScope.of(context).unfocus();
    if (widget.conditional != null) {
      if (!await widget.conditional!()) return;
    }

    setState(() {
      active = value ?? !active;
    });

    if (widget.onChanged != null) {
      widget.onChanged?.call(value ?? active);
    }
  }

  Widget switchWidget(BuildContext context) {
    return FormField<bool>(
      onSaved: (value) {
        final dataForm = DataFormState.maybeOf(context);
        dataForm?.saveField(
          id: widget.id,
          value: active,
        );
      },
      builder: (state) => SizedBox(
        width: 51,
        child: FittedBox(
          fit: BoxFit.fill,
          child: CupertinoSwitch(
            value: active,
            //thumbIcon: MaterialStatePropertyAll(widget.thumbIcon),
            trackColor: widget.trackColor,
            thumbColor: widget.thumbColor,
            activeColor: Theme.of(context).primaryColor,
            onChanged: _onChange,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: widget.colorScheme,
      ),
      child: InkWell(
        onTap: _onChange,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: context.scheme.surfaceVariant,
          ),
          child: Row(
            children: [
              if (widget.switchPosition == SwitchPosition.left) ...[
                switchWidget(context),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
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
                  ],
                ),
              ),
              if (widget.switchPosition == SwitchPosition.right) ...[
                const SizedBox(width: 10),
                switchWidget(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
