import 'package:flutter/material.dart';

import '../../services/dependency/dependency_service.dart';

class FeatureFlow {
  final Widget Function(
    BuildContext,
    Map<String, dynamic>,
  )? builder;

  final Function? action;

  FeatureFlow({
    this.builder,
    this.action,
  });

  static Widget build({
    required BuildContext context,
    required String tag,
    Map<String, dynamic> params = const {},
  }) {
    return Dependency.get<FeatureFlow>(tag).builder?.call(context, params) ??
        const SizedBox();
  }
}
