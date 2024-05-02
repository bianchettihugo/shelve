import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelve/core/utils/extensions.dart';
import 'package:shelve/shelve_app.dart';

import 'flow_page_base.dart';

class FlowWidget extends StatefulWidget {
  final List<FlowPageBase> pages;
  final Completer<Map<String, dynamic>?>? completer;
  final void Function(Map<String, dynamic>? result)? onCompleted;
  final bool disposeCompleter;

  const FlowWidget({
    super.key,
    required this.pages,
    this.completer,
    this.onCompleted,
    this.disposeCompleter = true,
  });

  @override
  State<FlowWidget> createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  final app = ShelveApp();
  final PageController controller = PageController();
  final pages = <FlowPageBase>[];
  final controllers = <String, TextEditingController>{};
  final focusNodes = <FocusNode>[];

  void onFlowCompleted() {
    int count = 0;
    final result = <String, dynamic>{};
    controllers.forEach((key, value) {
      final converter = widget.pages[count].converter;
      result[key] = converter?.call(value.text) ?? value.text;
      count++;
    });

    if (widget.onCompleted != null) {
      widget.onCompleted!.call(result);
    } else {
      app.context.pop(result);
    }
  }

  @override
  void initState() {
    for (int i = 0; i < widget.pages.length; i++) {
      final textController =
          widget.pages[i].controller ?? TextEditingController();
      controllers[widget.pages[i].key] = textController;
      focusNodes.add(FocusNode());
      pages.add(widget.pages[i].copyWith(
        buttonText: i == widget.pages.length - 1
            ? app.context.strings.finish
            : app.context.strings.continueBtn,
        controller: textController,
        focusNode: focusNodes[i],
        onNextButtonPressed: () {
          if (i == widget.pages.length - 1) {
            onFlowCompleted();
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
            Future.delayed(const Duration(milliseconds: 210), () {
              focusNodes[i + 1].requestFocus();
            });
          }
        },
        onBackButtonPressed: () {
          if (i == 0) {
            FocusScope.of(context).unfocus();
            app.context.pop();
            if (widget.completer?.isCompleted == false) {
              widget.completer?.complete(null);
            }
            return;
          }
          controller.previousPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
          Future.delayed(const Duration(milliseconds: 210), () {
            focusNodes[i - 1].requestFocus();
          });
        },
      ));
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controllers.forEach((key, value) {
      value.dispose();
    });
    for (var element in focusNodes) {
      element.dispose();
    }
    if (widget.disposeCompleter && widget.completer?.isCompleted == false) {
      widget.completer?.complete(null);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.hasClients && controller.page == 0,
      onPopInvoked: (popped) {
        if (controller.hasClients && controller.page == 0) {
          FocusScope.of(context).unfocus();
          app.context.pop();
          if (widget.completer?.isCompleted == false) {
            widget.completer?.complete(null);
          }
        } else {
          controller.previousPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
          Future.delayed(const Duration(milliseconds: 210), () {
            if (controller.hasClients) {
              focusNodes[controller.page?.round() ?? 0].requestFocus();
            }
          });
        }
      },
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: pages.map((e) => e.build(context)).toList(),
        ),
      ),
    );
  }
}
