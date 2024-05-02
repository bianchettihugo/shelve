import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show AnimatedBuilder, BuildContext, StatelessWidget, Widget;

class MultiValueListenableBuilder extends StatelessWidget {
  final Map<String, ValueListenable> valueListenables;

  final Widget Function(
      BuildContext context, Map<String, dynamic> values, Widget? child) builder;

  final Widget? child;

  const MultiValueListenableBuilder({
    super.key,
    required this.valueListenables,
    required this.builder,
    this.child,
  }) : assert(valueListenables.length != 0);

  @override
  Widget build(BuildContext context) {
    final valueListenables = this.valueListenables.values.toList();
    return AnimatedBuilder(
      animation: Listenable.merge(valueListenables.toList()),
      builder: (context, child) {
        final map = this
            .valueListenables
            .map((key, value) => MapEntry(key, value.value));

        return builder(context, map, child);
      },
      child: child,
    );
  }
}
