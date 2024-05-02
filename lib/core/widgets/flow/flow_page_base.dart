import 'package:flutter/material.dart';

abstract class FlowPageBase<T> {
  final T Function(String)? converter;
  final TextEditingController? controller;

  FlowPageBase({required this.converter, this.controller});

  Widget build(BuildContext context);

  FlowPageBase copyWith({
    VoidCallback? onBackButtonPressed,
    VoidCallback? onNextButtonPressed,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? buttonText,
  });

  String get key;
}
