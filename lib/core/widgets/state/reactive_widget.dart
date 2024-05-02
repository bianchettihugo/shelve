import 'package:flutter/material.dart';

import '../../utils/state.dart';

class ReactiveWidget<E extends Exception, S> extends StatelessWidget {
  final ReactiveState<E, S> state;
  final Widget child;
  final Widget Function(BuildContext) onLoading;
  final Widget Function(BuildContext, E) onError;
  final Widget Function(BuildContext, S) onSuccess;

  const ReactiveWidget({
    required this.state,
    required this.onLoading,
    required this.onError,
    required this.onSuccess,
    this.child = const SizedBox(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: state,
      child: child,
      builder: (context, state, child) {
        if (state is LoadingState) {
          return onLoading(context);
        } else if (state.isError) {
          return onError(context, state.error);
        } else if (state.isSuccess) {
          return onSuccess(context, state.data);
        }

        return child!;
      },
    );
  }
}
