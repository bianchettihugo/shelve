import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shelve/core/utils/extensions.dart';

import '../../theme/iconcino_icons.dart';
import '../buttons/button.dart';
import '../buttons/link_button.dart';
import '../input/text_input.dart';
import 'flow_page_base.dart';

class FlowTextPage<T> extends FlowPageBase<T> {
  final String id;
  final String title;
  final String description;
  final String buttonText;
  final String label;
  final TextInputType? inputType;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onNextButtonPressed;
  final bool Function(String)? condition;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool password;
  final FocusNode? focusNode;

  FlowTextPage({
    required this.id,
    required this.title,
    required this.description,
    this.buttonText = '',
    this.label = '',
    this.inputType = TextInputType.text,
    this.onBackButtonPressed,
    this.onNextButtonPressed,
    this.condition,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.password = false,
    this.focusNode,
    super.controller,
    super.converter,
  });

  @override
  Widget build(BuildContext context) {
    bool buttonActive = false;
    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: context.scheme.background,
          leadingWidth: 74,
          leading: IconButton(
            icon: const Icon(Iconcino.arrow_back_simple),
            color: context.scheme.onBackground,
            onPressed: onBackButtonPressed,
          ),
        ),
        body: AnimationLimiter(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        AnimationConfiguration.staggeredList(
                          position: 0,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            curve: Curves.easeInOutCubic,
                            child: FadeInAnimation(
                              child: Text(
                                title,
                                style: context.text.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        AnimationConfiguration.staggeredList(
                          position: 0,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            curve: Curves.easeInOutCubic,
                            child: FadeInAnimation(
                              child: Text(
                                description,
                                style: context.text.bodyMedium?.copyWith(
                                  color: context.scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimationConfiguration.staggeredList(
                          position: 0,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            curve: Curves.easeInOutCubic,
                            child: FadeInAnimation(
                              child: TextInput(
                                label: label,
                                controller: controller,
                                focus: focusNode,
                                autoDispose: false,
                                obscure: password,
                                onChanged: (str) {
                                  final conditionResult =
                                      condition?.call(str) ?? true;
                                  if (str.isNotEmpty &&
                                      conditionResult &&
                                      !buttonActive) {
                                    setState(() {
                                      buttonActive = true;
                                    });
                                  } else if ((str.isEmpty ||
                                          !conditionResult) &&
                                      buttonActive) {
                                    setState(() {
                                      buttonActive = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        if (secondaryButtonText != null &&
                            onSecondaryButtonPressed != null)
                          AnimationConfiguration.staggeredList(
                            position: 1,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              curve: Curves.easeInOutCubic,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: LinkButton(
                                    alignment: Alignment.centerLeft,
                                    onPressed: onSecondaryButtonPressed!,
                                    text: secondaryButtonText!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Button(
                  text: buttonText,
                  enabled: buttonActive,
                  onPressed: onNextButtonPressed ??
                      () {
                        FocusScope.of(context).unfocus();
                      },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  FlowPageBase copyWith({
    String? title,
    String? description,
    String? buttonText,
    TextInputType? inputType,
    T Function(String)? converter,
    VoidCallback? onBackButtonPressed,
    VoidCallback? onNextButtonPressed,
    TextEditingController? controller,
    bool Function(String)? condition,
    bool? password,
    FocusNode? focusNode,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonPressed,
  }) {
    return FlowTextPage(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      buttonText: buttonText ?? this.buttonText,
      inputType: inputType ?? this.inputType,
      converter: converter ?? this.converter,
      onBackButtonPressed: onBackButtonPressed ?? this.onBackButtonPressed,
      onNextButtonPressed: onNextButtonPressed ?? this.onNextButtonPressed,
      controller: controller ?? this.controller,
      condition: condition ?? this.condition,
      password: password ?? this.password,
      focusNode: focusNode ?? this.focusNode,
      secondaryButtonText: secondaryButtonText ?? this.secondaryButtonText,
      onSecondaryButtonPressed:
          onSecondaryButtonPressed ?? this.onSecondaryButtonPressed,
    );
  }

  @override
  String get key => id;
}
